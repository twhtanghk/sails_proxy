module.exports = (req, res, next) ->
  if req.user.email in sails.config.admin
    return next()
  res.forbidden "#{req.user.email} not in #{JSON.stringify sails.config.admin}"
