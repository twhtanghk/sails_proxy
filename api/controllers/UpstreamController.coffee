_ = require 'lodash'
Promise = require 'bluebird'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = 
  ###
  values:
    upstreams: [id1, id2, ...]
    updatedBy: email
  ###
  reorder: (req, res) ->
    values = actionUtil.parseValues req
    Promise
      .all _.map values.upstreams, (upstream, index) ->
        sails.models.upstream
          .findOneById upstream
          .then (app) ->
            _.extend app,
              order: index
              updatedBy: values.updatedBy 
            app
              .save()
              .then ->
                app
      .then res.ok, res.serverError

  getPhoto: (req, res) ->
    pk = actionUtil.requirePk(req)
    Model = actionUtil.parseModel(req)
    sails.services.file.get(Model, pk, 'photo')
      .then (data) ->
        if data
          [data, type, content] = data.match(/^data:(.+);base64,(.*)$/)
          res.set('Content-Type', type)
          res.send(200, new Buffer(content, 'base64'))
        else
          res.ok()
      .catch res.serverError
