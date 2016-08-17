_ = require 'lodash'

_.defaults process.env,
  PORT: 1337
  xfwd: 'true'
  prependPath: 'false'
  ignorePath: 'false'

module.exports =
  target: '.*'
  xfwd: process.env.xfwd == 'true'
  prependPath: process.env.prependPath == 'true'
  ignorePath: process.env.ignorePath == 'true'
