Sails = require 'sails'
fs = require 'fs'
config = JSON.parse fs.readFileSync './.sailsrc'
timeout = 50000000

before (done) ->
  @timeout timeout

  Sails.lift config, (err, app) ->
    if err
      return done err
    done null, Sails
		
after (done) ->
  Sails.lower done
