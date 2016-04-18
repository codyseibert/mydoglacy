models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'

module.exports = do ->

  post: (req, res) ->
    Users.findOne(req.body).then (results) ->
      if not results?
        res.status 403
        res.send 'invalid login'
      else
        res.status 200
        res.send 'login valid, please set headers'
