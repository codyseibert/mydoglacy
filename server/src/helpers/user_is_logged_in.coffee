Base64 = require('js-base64').Base64
Users = require('../models/models').Users
jwt = require 'jsonwebtoken'

TOKEN_PASSWORD = process.env.JWT_PASSWORD

module.exports = (req, res, next) ->
  auth = req.headers.authorization
  try
    token = auth.split(' ')[1]
    jwt.verify token, TOKEN_PASSWORD, (err, decoded) ->
      if err?
        req.status 400
        res.send 'invalid token'
      else
        req.user = decoded._doc
        next()
  catch err
    res.status 401
    res.send 'missing authorization header'
