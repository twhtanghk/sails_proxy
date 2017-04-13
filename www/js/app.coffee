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
require 'ngImgCrop'
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
    'ngImgCrop'
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

  # image crop
  .run ($rootScope, $ionicModal) ->
    $rootScope.$on 'cropImg', (event, inImg, id) ->
      _.extend $rootScope,
        model:
          inImg: inImg
          outImg: ''
        confirm: ->
          $rootScope.$broadcast 'cropImg.completed', $rootScope.model.outImg, id
          $rootScope.modal?.remove()
      $ionicModal.fromTemplateUrl 'templates/img/crop.html', scope: $rootScope
        .then (modal) ->
          modal.show()
          $rootScope.modal = modal
