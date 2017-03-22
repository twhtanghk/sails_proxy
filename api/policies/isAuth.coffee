module.exports = (req, res, next) ->
  if req.headers['x-forwarded-email']?
    next()
  else
    res.forbidden()
