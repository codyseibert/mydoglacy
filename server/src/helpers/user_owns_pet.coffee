Base64 = require('js-base64').Base64
Pets = require('../models/models').Pets

module.exports = (req, res, next) ->

  petId = req.params.id

  Pets.findById(petId).then (pet) ->
    if not pet?
      res.status 404
      res.send 'pet not found with id'
    else if "#{pet.userId}" isnt "#{req.user._id}"
      res.status 400
      res.send 'You do not have access to this pet'
    else
      next()
