mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  name: String
  breed: String
  date_of_birth: Date
  date_of_death: Date
  biography: String
  images: Array
  stories: Array
  subscriptionId: String
  userId: ObjectId
  activeUntil: Date
