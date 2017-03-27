_ = require 'lodash'

module.exports =
  tableName: 'upstream'
  schema: true
  autoPK: true
  attributes:
    prefix:
      type: 'string'
      required: true
      defaultsTo: '/prefix'
    target:
      type: 'string'
      required: true
      defaultsTo: 'http://echo'
    order:
      type: 'integer'
      required: true
    createdBy:
      model: 'user'
      required: true
    updatedBy:
      model: 'user'

  # convert [upstream...] to { prefix1: target1, prefix2: target2, ... }
  toRouter: (upstreams) ->
    ret = {}
    _.each upstreams, (upstream) ->
      ret[upstream.prefix] = upstream.target
    return ret
    
  # convert [upstream...] to { ^prefix1: /, ^prefix2: /, ... }
  toPathRewrite: (upstreams) ->
    ret = {}
    _.each upstreams, (upstream) ->
      ret["^#{upstream.prefix}"] = '/'
    return ret

  # return http-proxy-middleware instance with existing saved upstream settings
  middleware: (req, res, next) ->
    @proxy req, res, next

  # reload router settings
  reload: ->
    @find()
      .sort order: 1  # in ascending order
      .then (upstreams) =>
        @router = @toRouter upstreams
        _.extend sails.config.proxy, router: @router,
        if not sails.config.proxy.prependPath
          _.extend sails.config.proxy, pathRewrite: @toPathRewrite upstreams
        @proxy = require('http-proxy-middleware') sails.config.proxy
        sails.log.info "proxy reloaded"
    
  beforeValidate: (values, cb) ->
    @find()
      .max 'order'
      .then (res) ->
        values.order ?= if res.length == 0 then 0 else res[0].order + 1
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
