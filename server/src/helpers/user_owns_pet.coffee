Base64 = require('js-base64').Base64
Pets = require('../models/models').Pets

module.exports = (req, res, next) ->

  petId = req.id

  Pets.findById(petId).then (pet) ->
    if pet.userId isnt req.user.id
      res.status 400
      res.send 'You do not have access to this pet'
    else
      next()
