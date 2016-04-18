mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  id: ObjectId
  snippit: ObjectId
  user: ObjectId
