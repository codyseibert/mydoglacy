mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  id: ObjectId
  user_id: ObjectId
  name: String
  code: String
  language: String
