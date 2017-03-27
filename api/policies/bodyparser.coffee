module.exports = (req, res, next) ->
  sails.config.http.middleware.bodyParser req, res, next
