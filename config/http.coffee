module.exports =
  http:
    middleware:
      proxy: (req, res, next) ->
        sails.models.upstream.middleware req, res, next
      order: [
        'compress'
        'router'
        'www'
        'proxy'
        'favicon'
        '404'
        '500'
      ]
