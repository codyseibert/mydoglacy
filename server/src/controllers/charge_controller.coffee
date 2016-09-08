models = require '../models/models'
lodash = require 'lodash'
Pets = models.Pets
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId

module.exports = do ->

  post: (req, res) ->
    stripe = require('stripe')('sk_test_pWy8lKC1ZXDI29NCbATR3fs9')
    stripeToken = req.body.stripeToken
    email = req.body.email
    pet = req.body.page
    user = {}

    if not stripeToken? or not email? or not pet?
      res.status 400
      res.send 'invalid parameters'
      return

    stripe.customers.create
      source: stripeToken.id
      plan: "basic"
      email: email
    , (err, customer) ->
      if err
        res.status 400
        res.send 'card was declined' + err
        return

      user.stripeId = customer.id

      stripe.subscriptions.create
        customer: customer.id
        plan: 'basic'
        metadata:
          petId: pet._id
      , (subErr, subscription) ->
        if subErr
          res.status 400
          res.send 'subscription failed ' + subErr
          return

        Pets.findById(pet._id)
          .then (p) ->
            p.subscriptionId = subscription.id
            p.userId = ObjectId(req.user._id)
            activeUntil = new Date()
            activeUntil.setFullYear(activeUntil.getFullYear() + 1)
            p.activeUntil = activeUntil
            p.save (err) ->
              res.status 200
              res.send p
