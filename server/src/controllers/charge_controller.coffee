models = require '../models/models'
lodash = require 'lodash'
Pets = models.Pets
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
Joi = require 'joi'

stripe = require('stripe') 'sk_test_pWy8lKC1ZXDI29NCbATR3fs9'

log4js = require 'log4js'
logger = log4js.getLogger 'app'

module.exports = do ->

  webhook: (req, res) ->
    event = req.body
    logger.info "we received a #{event.type} webhook of id #{event.id}: #{JSON.stringify event}"
    stripe.events.retrieve event.id, (err, e) ->
      if err?
        logger.error "we could not verify the event passed in from stripe #{JSON.stringify err}"
        res.status 400
        res.send 'failed to verify with stripe ' + err
      else
        if e.type is 'invoice.payment_succeeded'
          subscription = e.data.object.subscription
          Pets.findOne(subscriptionId: subscription).then (pet) ->
            if not pet?
              logger.error "a invoice.payment_succeeded was processed, but no associated pet was found: subscription=#{subscription}"
            else
              pet.isSubscriptionCanceled = false
              activeUntil = new Date()
              activeUntil.setFullYear(activeUntil.getFullYear() + 1)
              pet.activeUntil = activeUntil
              pet.save().then ->
                res.status 200
                res.send 'success'
        else
          res.status 200
          res.send 'success'

  delete: (req, res) ->
    petId = req.params.id
    logger.info "the petId=#{petId} from userId=#{req.user._id} has requested to delete their subscription"
    Pets.findById(petId).then (pet) ->
      if not pet?
        logger.error "the petId=#{petId} subscription requested for deletion was not found"
        res.status 400
        res.send 'pet not found'
      else if not pet.subscriptionId?
        logger.error "the petId=#{petId} subscription requested for deletion did not have a subscriptionId"
        res.status 400
        res.send 'this pet did not have a subscriptionId'
      else
        subscriptionId = pet.subscriptionId
        stripe.subscriptions.del subscriptionId, (err, confirmation) ->
          if err?
            logger.error "we were not able to delete the subcription given for petId=#{petId} from userId=#{req.user._id}"
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
          logger.error "a customers card was declined for email=#{email} petId=#{pet._id}"
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
              logger.error "the subscrition failed for customers customerId=#{customer.id} petId=#{pet._id}"
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
                  logger.info "the subscrition successed for customers customerId=#{customer.id} petId=#{pet._id}"
                  p.save().then ->
                    res.status 200
                    res.send p
