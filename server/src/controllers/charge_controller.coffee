models = require '../models/models'
lodash = require 'lodash'
Pets = models.Pets
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
Joi = require 'joi'

stripe = require('stripe') 'sk_test_pWy8lKC1ZXDI29NCbATR3fs9'

module.exports = do ->

  webhook: (req, res) ->
    event = req.body
    console.log 'event received on webhook endpoint', event
    stripe.events.retrieve event.id, (err, e) ->
      if err?
        res.status 400
        res.send 'failed to verify with stripe'
      else
        if e.type is 'invoice.payment_succeeded'
          customerId = e.data.object.customer
          Pets.find(customerId: customerId).then (pet) ->
            pet.isSubscriptionCanceled = false
            activeUntil = new Date()
            activeUntil.setFullYear(activeUntil.getFullYear() + 1)
            pet.activeUntil = activeUntil
            p.save().then ->
              res.status 200
              res.send 'success'
        else
          res.status 200
          res.send 'success'

  delete: (req, res) ->
    petId = req.params.id
    Pets.findById(petId).then (pet) ->
      if not pet?
        res.status 400
        res.send 'pet not found'
      else if not pet.subscriptionId?
        res.status 400
        res.send 'this pet did not have a subscriptionId'
      else
        subscriptionId = pet.subscriptionId
        stripe.subscriptions.del subscriptionId, (err, confirmation) ->
          if err?
            res.status 400
            res.send 'error ending subscription' + err
          else
            pet.isSubscriptionCanceled = true
            pet.save().then ->
              res.status 200
              res.send 'subscription canceled'

  post: (req, res) ->
    stripeToken = req.body.stripeToken
    email = req.body.email
    pet = req.body.page
    user = {}

    if not stripeToken? or not email? or not pet?
      res.status 400
      res.send 'invalid parameters'
    else
      stripe.customers.create
        source: stripeToken.id
        plan: "basic"
        email: email
      , (err, customer) ->
        if err?
          res.status 400
          res.send 'card was declined' + err
        else
          stripe.subscriptions.create
            customer: customer.id
            plan: 'basic'
            metadata:
              petId: pet._id
          , (subErr, subscription) ->
            if subErr?
              res.status 400
              res.send 'subscription failed ' + subErr
            else
              Pets.findById(pet._id)
                .then (p) ->
                  p.customerId = customer.id
                  p.subscriptionId = subscription.id
                  p.userId = ObjectId(req.user._id)
                  p.isSubscriptionCanceled = false
                  activeUntil = new Date()
                  activeUntil.setFullYear(activeUntil.getFullYear() + 1)
                  p.activeUntil = activeUntil
                  p.save().then ->
                    res.status 200
                    res.send p
