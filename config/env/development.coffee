module.exports =
  models:
    migrate: 'drop'
  isAuth: (req) ->
    req.headers['x-forwarded-email'] = sails.config.adminGrp[0]
    req.headers['x-forwarded-email'] in sails.config.adminGrp
  proxy: require process.env.upstream || './upstream.coffee'
  log:
    level: 'silly'
