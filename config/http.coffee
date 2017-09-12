module.exports =
  http:
    middleware:
      proxy: (req, res, next) ->
        sails.models.upstream.middleware req, res, next
      order: [
        'proxy'
        'compress'
        'bodyParser'
        'router'
        'www'
        'favicon'
        '404'
        '500'
      ]
