module.exports = (req, res, next) ->
  if sails.config.isAuth req
    next()
  else
    res.forbidden()
