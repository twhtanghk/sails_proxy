require './controller.coffee'
require 'angular-xeditable'
window.jQuery = require 'jquery'
require 'bootstrap'

angular.module 'starter', ['ionic', 'starter.controller', 'xeditable']
  .run (editableOptions) ->
    editableOptions.theme = 'bs3'
