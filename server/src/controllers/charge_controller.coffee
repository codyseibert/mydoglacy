lodash = require 'lodash'

module.exports = do ->

  post: (req, res) ->
    stripe = require('stripe')('sk_test_pWy8lKC1ZXDI29NCbATR3fs9')
    stripeToken = req.body.stripeToken
    user = req.user
    pet = req.body.pet

    console.log stripeToken
    res.status 200
    res.send 'success'
    return

    stripe.customers.create
      source: stripeToken
      plan: "basic"
      email: req.body.email
    , (err, customer) ->
      if err && err.type is 'StripeCardError'
        res.status 400
        res.send 'card was declined' + err
        return

      user.stripeId = customer.id

      stripe.subscriptions.create
        customer: customer.id
        plan: 'basic'
        metadata:
          pet: pet.id
      , (subErr, subscription) ->
        if subErr
          res.status 400
          res.send 'subscription failed ' + subErr
          return

        pet.subscriptionId = subscription.id
        pet.userId = user.id
        activeUntil = new Date()
        activeUntil.setFullYear(activeUntil.getFullYear() + 1)
        pet.activeUntil = activeUntil
        pet.save()

        res.status 200
        res.send 'success'
