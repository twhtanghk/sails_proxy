_ = require 'lodash'

if not ('admin' of process.env)
  throw new Error 'process.env.admin not yet defined'

module.exports =
  admin: _.split process.env.admin, ','
