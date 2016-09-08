Base64 = require('js-base64').Base64
Users = require('../models/models').Users
jwt = require 'jsonwebtoken'

TOKEN_PASSWORD = process.env.JWT_PASSWORD

module.exports = (req, res, next) ->
  auth = req.headers.authorization
  try
    token = auth.split(' ')[1]
    jwt.verify token, TOKEN_PASSWORD, (err, decoded) ->
      if decoded?._doc?
        req.user = decoded._doc
      else
        req.user = null
      next()
  catch err
    next()
