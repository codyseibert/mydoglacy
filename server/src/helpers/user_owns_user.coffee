Base64 = require('js-base64').Base64
Users = require('../models/models').Users

module.exports = (req, res, next) ->

  userId = req.params.id

  Users.findById(userId).then (user) ->
    if not user?
      res.status 404
      res.send 'user not found with id'
    else if "#{user._id}" isnt "#{req.user._id}"
      res.status 401
      res.send 'You do not have access to this user'
    else
      next()
