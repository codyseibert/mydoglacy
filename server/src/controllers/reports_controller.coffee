models = require '../models/models'
Reports = models.Reports
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'

module.exports = do ->

  index: (req, res) ->
    user_id = req.user._id
    Reports.find(user_id: user_id).then (obj) ->
      res.status 200
      res.send obj
  #
  # show: (req, res) ->
  #   Reports.findById(req.params.id).then (obj) ->
  #     res.status 200
  #     res.send obj

  post: (req, res) ->
    req.body.user_id = req.user._id
    req.body.date = new Date()
    Reports.create(req.body).then (obj) ->
      res.status 200
      res.send obj

  # put: (req, res) ->
  #   Reports.update(_id: new ObjectId(req.params.id), req.body).then (obj) ->
  #     res.status 200
  #     res.send obj
  #
  # destroy: (req, res) ->
  #   Reports.findById(req.params.id).remove().then (obj) ->
  #     res.status 200
  #     res.send obj
