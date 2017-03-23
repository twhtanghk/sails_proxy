_ = require 'lodash'
url = require 'url'
require './controller.coffee'
require 'angular-xeditable'
window.jQuery = require 'jquery'
require 'bootstrap'
require 'ng-sortable'
require 'log_toast'
require './templates'
require 'sails-auth'
require 'util.auth'
env = require './config.json'
window.io = require('sails.io.js')(require('socket.io-client'))
_.extend window.io.sails,
  url: env.ROOTURL
  path: "#{url.parse(env.ROOTURL).pathname}/socket.io"

angular
  .module 'starter', [
    'ionic'
    'starter.controller'
    'templates'
    'xeditable'
    'as.sortable'
    'logToast'
    'http-auth-interceptor'
    'util.auth'
  ]
  .run (editableOptions) ->
    editableOptions.theme = 'bs3'
  .run (authService) ->
    authService.login
      authUrl: env.AUTHURL
      client_id: env.CLIENT_ID
      scope: env.SCOPE
      response_type: 'token'
