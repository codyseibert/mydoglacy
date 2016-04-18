mongoose = require 'mongoose'

module.exports =
  Users: mongoose.model 'Users', require './users'
  Snippits: mongoose.model 'Snippits', require './snippits'
  Reports: mongoose.model 'Reports', require './reports'
  Favorites: mongoose.model 'Favorites', require './favorites'
