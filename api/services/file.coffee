module.exports =
  # get file content of Model[field] from model user or group
  get: (Model, pk, field) ->
    Model
      .findOne pk
      .then (data) ->
        data[field]
