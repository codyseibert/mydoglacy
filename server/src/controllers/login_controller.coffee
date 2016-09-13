models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
jwt = require 'jsonwebtoken'
crypto = require 'crypto'

config = require '../config/config'
TOKEN_PASSWORD = config.JWT_PASSWORD

module.exports = do ->

  post: (req, res) ->
    email = req.body.email
    password = req.body.password

    Users.findOne(email: email)
      .then (user) ->

        if not user?
          res.status 404
          res.send 'user not found'
          return

        hash = crypto
          .createHmac 'sha1', user.salt
          .update password
          .digest 'hex'

        if hash is user.password
          jwt.sign user, TOKEN_PASSWORD, algorithm: 'HS256', (err, token) ->
            res.status 200
            res.send token
        else
          res.status 401
          res.send 'invalid password'
