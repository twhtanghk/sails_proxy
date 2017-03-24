['ROOTURL'].map (name) ->
  if not (name of process.env)
    throw new Error "process.env.#{name} not yet defined"

module.exports =
  bootstrap: (done) ->
    sails.io.of require('url').parse(process.env.ROOTURL).pathname
    sails.models.upstream.reload()
      .then done
      .catch done
