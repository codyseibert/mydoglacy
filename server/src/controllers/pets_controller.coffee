models = require '../models/models'
Pets = models.Pets
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
classifier = require 'language-classifier'

module.exports = do ->

  index: (req, res) ->
    # query = req.query
    # if req.query['_id$in']
    #   query =
    #     '_id':
    #       $in: req.query['_id$in'].split ','
    Pets.find(userId: req.user._id).then (collection) ->
      res.status 200
      res.send collection

  show: (req, res) ->
    Pets.findById(req.params.id).then (obj) ->
      res.status 200
      res.send obj

  post: (req, res) ->
    req.body.userId = req.user._id
    Pets.create(req.body).then (obj) ->
      res.status 200
      res.send obj

  put: (req, res) ->
    Pets.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
      res.status 200
      res.send obj

  destroy: (req, res) ->
    Pets.findById(req.params.id).remove().then (obj) ->
      res.status 200
      res.send obj
