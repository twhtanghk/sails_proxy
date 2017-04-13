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
window.io = require('sails.io.js')(require('socket.io-client'))

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
  .run ($rootScope, $location) ->
    _.extend $rootScope, pathname: url.parse(window.location.href).pathname
  .run (editableOptions) ->
    editableOptions.theme = 'bs3'
  .run (authService) ->
    authService.login
      authUrl: env.AUTHURL
      client_id: env.CLIENT_ID
      scope: env.SCOPE
      response_type: 'token'
