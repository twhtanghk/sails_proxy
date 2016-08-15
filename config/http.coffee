_ = require 'lodash'
express = require 'express'
proxy = null

module.exports =
  http:
    middleware:
      static: express.static 'www'
      proxy: (req, res, next) ->
        sails.models.upstream.middleware req, res, next
      order: [
        'bodyParser'
        'handleBodyParserError'
        'compress'
        'router'
        'static'
        'proxy'
        'favicon'
        '404'
        '500'
      ]
