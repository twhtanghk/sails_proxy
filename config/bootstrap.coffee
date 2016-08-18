_ = require 'lodash'

module.exports =
  bootstrap: (cb) ->
    # findOrCreate default echo service
    sails.models.upstream
      .findOrCreate {prefix: '/echo'}, 
        prefix: process.env.echoPrefix || '/echo'
        target: process.env.echoTarget || 'http://echo:1338'
        order: 0
        createdBy: sails.config.admin[0]
      .then ->
        # reload proxy settings and initialize proxy
        sails.models.upstream.reload()
      .then ->
        sails.log.info _.pick(sails.config, 'proxy', 'admin', 'port')
        cb()
      .catch cb
