[ 'echoPrefix', 'echoTarget' ].map (name) ->
  if not (name of process.env)
    throw new Error "process.env.#{name} not yet defined"

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
        cb()
      .catch cb
