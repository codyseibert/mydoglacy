require '../db'
models = require '../models/models'
Promise = require 'bluebird'

Users = models.Users
Snippits = models.Snippits
Reports = models.Reports

promises = []

promises.push Users.create
  email: 'cseibert113@gmail.com'
  password: '123456'

promises.push Snippits.create
  name: 'Random Snippit 1'
  code: """
    Users = models.Users
    Snippits = models.Snippits
    Reports = models.Reports

    Users.create
      email: 'cseibert113@gmail.com'
      password: '123456'
  """
  language: "coffeescript"

promises.push Snippits.create
  name: 'Random Snippit 2'
  code: """
    var Base64, Users;

    Base64 = require('js-base64').Base64;

    Users = require('../models/models').Users;

    module.exports = function(req, res, next) {

    }
  """
  language: "javascript"

Promise.all promises
  .then ->
    process.exit 0
