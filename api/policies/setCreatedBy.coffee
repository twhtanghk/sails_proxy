_ = require 'lodash'

module.exports = (req, res, next) ->
  req.options.values ?= {}
  _.extend req.options.values, createdBy: req.headers['x-forwarded-email']
  next()
