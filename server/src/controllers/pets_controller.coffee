models = require '../models/models'
Pets = models.Pets
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
moment = require 'moment'

log4js = require 'log4js'
logger = log4js.getLogger 'app'

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
    if not ObjectId.isValid req.params.id
      res.status 404
      res.send 'invalid object id'
    else
      Pets.findById(req.params.id).then (obj) ->
        if not obj?
          res.status 404
          res.send 'no pet found with the given id'
        else if req.user?._id? and "#{obj.userId}" is "#{req.user._id}"
          res.status 200
          res.send obj
        else if not obj.activeUntil? or not moment().isBefore(moment(obj.activeUntil))
          res.status 400
          res.send 'pet is not published'
        else
          res.status 200
          res.send obj

  post: (req, res) ->
    req.body.userId = new ObjectId(req.user._id)
    Pets.create(req.body)
      .then (pet) ->
        res.status 200
        res.send pet
      .catch (err) ->
        logger.error "an attempt was made to create a pet that already existed petId=#{req.body._id}"
        res.status 400
        res.send 'pet already exists'

  put: (req, res) ->
    petId = new ObjectId req.params.id
    Pets.update(_id: petId, req.body).then (obj) ->
      res.status 200
      res.send obj

  destroy: (req, res) ->
    Pets.findById(req.params.id).remove().then (obj) ->
      res.status 200
      res.send obj
