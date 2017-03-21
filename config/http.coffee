module.exports =
  http:
    middleware:
      proxy: (req, res, next) ->
        sails.models.upstream.middleware req, res, next
      order: [
        'bodyParser'
        'handleBodyParserError'
        'compress'
        'router'
        'www'
        'proxy'
        'favicon'
        '404'
        '500'
      ]
