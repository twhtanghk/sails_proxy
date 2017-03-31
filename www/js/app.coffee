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
url = require 'url'
env = require './config.json'
path = url.parse(window.location.href).pathname
window.io = require('sails.io.js')(require('socket.io-client'))
_.extend window.io.sails,
  url: path
  path: require('path').join path, "socket.io"

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
