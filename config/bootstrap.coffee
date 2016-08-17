module.exports =
  bootstrap: (cb) ->
    # add default echo upstream with next available port
    process.env.PORT = sails.config.port + 1

    # findOrCreate default echo service
    sails.models.upstream
      .findOrCreate {prefix: '/echo'}, 
        prefix: '/echo'
        target: "http://localhost:#{process.env.PORT}"
        order: 0
        createdBy: sails.config.adminGrp[0]
      .then ->

        # start echo server on next availabl port
        require 'http-echo-server'

        # reload proxy settings and initialize proxy
        sails.models.upstream.reload()
      .then ->
        cb()
      .catch cb
