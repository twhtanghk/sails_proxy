_ = require 'lodash'

module.exports =
  tableName: 'upstream'
  schema: true
  autoPK: true
  attributes:
    prefix:
      type: 'string'
      required: true
      unique: true
    target:
      type: 'string'
      required: true
    order:
      type: 'integer'
      required: true
    createdBy:
      type: 'email'
      required: true
    updatedBy:
      type: 'email'

  # convert [upstream...] to { prefix1: target1, prefix2: target2, ...}
  toRouter: (upstreams) ->
    ret = {}
    _.each upstreams, (upstream) ->
      ret[upstream.prefix] = upstream.target
    return ret
    
  # return http-proxy-middleware instance with existing saved upstream settings
  middleware: (req, res, next) ->
    # check if url matched any path defined in sails.config.proxy.router
    matched = _.some _.keys(@router), (pattern) ->
      new RegExp "^#{pattern}"
        .test req.url
    if matched
      @proxy req, res, next
    else
      next()

  # reload router settings
  reload: ->
    @find()
      .sort order: 1  # in ascending order
      .then (upstreams) =>
        @router = @toRouter upstreams
        _.extend sails.config.proxy, router: @router
        @proxy = require('http-proxy-middleware') sails.config.proxy
        sails.log.info "proxy reloaded"
    
  beforeValidate: (values, cb) ->
    @find()
      .max 'order'
      .then (res) ->
        values.order ?= res[0].order + 1
        cb()
      .catch cb

  afterCreate: (values, cb) ->
    @reload().then ->
      cb()

  afterUpdate: (values, cb) ->
    @reload().then ->
      cb()

  afterDestroy: (values, cb) ->
    @reload().then ->
      cb()
