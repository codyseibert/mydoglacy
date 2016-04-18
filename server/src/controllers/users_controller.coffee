models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'

module.exports = do ->
  
  index: (req, res) ->
    Users.find().then (obj) ->
      res.status 200
      res.send obj

  show: (req, res) ->
    Users.findById(req.params.id).then (obj) ->
      res.status 200
      res.send obj

  post: (req, res) ->
    Users.create(req.body).then (obj) ->
      res.status 200
      res.send obj

  put: (req, res) ->
    Users.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
      res.status 200
      res.send obj

  destroy: (req, res) ->
    Users.findById(req.params.id).remove().then (obj) ->
      res.status 200
      res.send obj
