module.exports =
  models:
    migrate: 'drop'
  isAuth: (req) ->
    req.headers['x-forwarded-email'] = sails.config.admin[0]
    req.headers['x-forwarded-email'] in sails.config.admin
  proxy: require process.env.upstream || './upstream.coffee'
  log:
    level: 'silly'
