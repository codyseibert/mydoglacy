models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
crypto = require 'crypto'

SALT_ROUNDS = 10

createSalt = ->
  Math.round((new Date().valueOf() * Math.random())) + ''

module.exports = do ->

  index: (req, res) ->
    query = req.query
    if req.query['_id$in']
      query =
        '_id':
          $in: req.query['_id$in'].split ','
    Users.find(query).then (obj) ->
      res.status 200
      res.send obj

  show: (req, res) ->
    Users.findById(req.params.id).then (obj) ->
      res.status 200
      res.send obj

  post: (req, res) ->
    user = req.body
    salt = createSalt()

    hash = crypto
      .createHmac 'sha1', salt
      .update user.password
      .digest 'hex'

    user.salt = salt
    user.password = hash

    Users.create(user).then (obj) ->
      res.status 200
      res.send obj

  put: (req, res) ->
    Users.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
      res.status 200
      res.send obj
