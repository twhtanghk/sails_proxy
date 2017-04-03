Promise = require 'bluebird'

module.exports =
  # get file content of Model[field] from model user or group
  get: (Model, pk, field) ->
    new Promise (fulfill, reject) ->
      Model
        .findOne(pk)
        .then (data) ->
          fulfill data[field]
        .catch reject
