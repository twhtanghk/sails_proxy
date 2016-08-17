require './controller.coffee'
require 'angular-xeditable'
window.jQuery = require 'jquery'
require 'bootstrap'
require 'ng-sortable'
require './templates'

angular.module 'starter', ['ionic', 'starter.controller', 'templates', 'xeditable', 'as.sortable']
  .run (editableOptions) ->
    editableOptions.theme = 'bs3'
