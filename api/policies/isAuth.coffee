module.exports = (req, res, next) ->
  if req.headers['x-forwarded-email'] in sails.config.admin
    next()
  else
    res.forbidden()
