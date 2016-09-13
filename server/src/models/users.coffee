mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  email: String
  password: String
  salt: String
  stripeId: String
  verify: String
  verified: Boolean
