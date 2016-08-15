_ = require 'lodash'
path = require 'path'
require './model.coffee'

angular.module 'starter.controller', ['starter.model', 'ionic']
  .controller 'UpstreamsCtrl', ($scope, $log, resource) ->
    collection = []
    resource.Upstream.fetchAll()
      .then (res) ->
        _.merge collection, res
    _.extend $scope, 
       showDelete: false
       collection: collection
       create: ->
         upstream = new resource.Upstream
           prefix: '/prefix'
           target: 'http://target:80'
         upstream
           .$save()
           .then ->
             collection.push upstream
           .catch $log.error

  .controller 'UpstreamCtrl', ($scope, $log) ->
    _.extend $scope,
      update: (values) ->
        $scope.model
          .$save values
          .then ->
            return true
          .catch (err) ->
            err.toString()
      destroy: ->
        id = $scope.model.id
        $scope.model
          .$destroy()
          .then ->
            _.remove $scope.collection, (model) ->
              model.id == id
          .catch $log.error
