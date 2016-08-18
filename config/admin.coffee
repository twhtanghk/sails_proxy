_ = require 'lodash'

_.defaults process.env,
  admin: 'admin@mob.myvnc.com'

module.exports =
  admin: _.split process.env.admin, ','
