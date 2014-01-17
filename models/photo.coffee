mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/express-mongoose'

schema = new mongoose.Schema
  name: String
  path: String

module.exports = mongoose.model('Photo', schema)
