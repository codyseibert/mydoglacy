models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
crypto = require 'crypto'
uuid = require 'node-uuid'
config = require '../config/config'

emailHelper = require '../helpers/email_helper'

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
    Users.findById(req.params.id).then (user) ->
      if not user?
        res.status 404
        res.send 'user not found'
      else
        res.status 200
        res.send user

  post: (req, res) ->
    user = req.body
    salt = createSalt()

    hash = crypto
      .createHmac 'sha1', salt
      .update user.password
      .digest 'hex'

    user.salt = salt
    user.password = hash

    Users.findOne(email: user.email).then (u) ->
      if u?
        res.status 400
        res.send 'user already exists with this email'
      else
        Users.create(user).then (obj) ->
          verify = uuid.v4()
          user.verify = verify
          user.save ->
            try
              emailHelper.send user.email, """
                Welcome to MyDogLacy!
              """, """
                Your account has been created!

                Please click the link below to verify your account.

                #{config.BASE_URL}/verify/#{verify}
              """
            res.status 200
            res.send obj

  put: (req, res) ->
    Users.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
      res.status 200
      res.send obj

  verify: (req, res) ->
    Users.findOne(verify: req.body.verify).then (user) ->
      if not user?
        res.status 400
        res.send 'invalid verification code'
      else
        user.verified = true
        user.save ->
          res.status 200
          res.send 'success'
