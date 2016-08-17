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
      .then (apps) ->
        res.ok apps
      .catch res.serverError
