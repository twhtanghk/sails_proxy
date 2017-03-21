[ 'xfwd', 'prependPath', 'ignorePath' ].map (name) ->
  if not (name of process.env)
    throw new Error "process.env.#{name} not yet defined"

module.exports =
  proxy:
    target: '.*'
    xfwd: process.env.xfwd == 'true'
    prependPath: process.env.prependPath == 'true'
    ignorePath: process.env.ignorePath == 'true'
