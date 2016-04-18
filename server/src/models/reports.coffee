mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  id: ObjectId
  user_id: ObjectId
  snippit_id: ObjectId
  accuracy: Number
  averageTokenLen: Number
  charsPerMin: Number
  correct: Number
  secElapsed: Number
  strokes: Number
  tokensPerMin: Number
  date: Date
