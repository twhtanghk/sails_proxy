module.exports =
  http:
    middleware:
      proxy: (req, res, next) ->
        sails.models.upstream.middleware req, res, next
      order: [
        'compress'
        'proxy'
        'router'
        'www'
        'favicon'
        '404'
        '500'
      ]
