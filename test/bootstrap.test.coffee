Promise = require 'bluebird'
Sails = Promise.promisifyAll require 'sails'
oauth2 = require 'oauth2_client'
fs = require 'fs'
config = JSON.parse fs.readFileSync './.sailsrc'
assert = require 'assert'

[
  'USER_ID'
  'USER_SECRET'
  'PASS_CLIENT_ID'
  'PASS_CLIENT_SECRET'
  'TOKENURL'
  'SCOPE'
].map (name) ->
  assert name of process.env, "process.env.#{name} not yet defined"

before ->
  user =
    id: process.env.USER_ID.split(',')[0]
    secret: process.env.USER_SECRET.split(',')[0]
  client =
    id: process.env.PASS_CLIENT_ID
    secret: process.env.PASS_CLIENT_SECRET
  scope = process.env.SCOPE.split ','
  oauth2
    .token process.env.TOKENURL, client, user, scope
    .then (token) ->
      global.token = token
    .then ->
      Sails.liftAsync config
		
after ->
  Sails.lowerAsync()
