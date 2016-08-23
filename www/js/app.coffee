require './controller.coffee'
require 'angular-xeditable'
window.jQuery = require 'jquery'
require 'bootstrap'
require 'ng-sortable'
require 'log_toast'
require './templates'

angular
  .module 'starter', [
    'ionic'
    'starter.controller'
    'templates'
    'xeditable'
    'as.sortable'
    'logToast'
  ]
  .run (editableOptions) ->
    editableOptions.theme = 'bs3'
