models = require '../models/models'
Favorites = models.Favorites
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'

module.exports = do ->

  index: (req, res) ->
    Favorites.find(user: req.user._id).then (obj) ->
      res.status 200
      res.send obj

  post: (req, res) ->
    favorite =
      snippit: req.body._id
      user: req.user._id
    Favorites.create(favorite).then (obj) ->
      res.status 200
      res.send obj

  destroy: (req, res) ->
    query =
      user: req.user._id
      snippit: req.params.id
    Favorites.findOne(query).remove().then (obj) ->
      res.status 200
      res.send obj
