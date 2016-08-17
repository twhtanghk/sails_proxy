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
       drag:
         itemMoved: (event) ->
           return true
         orderChanged: (event) ->
           _.remove $scope.collection, (model) ->
             model.id == event.source.itemScope.model.id
           $scope.collection.splice event.dest.index, 0, event.source.itemScope.model
           resource.Upstream
             .reorder $scope.collection
             .then (upstreams) ->
               $scope.collection.length = 0
               $scope.collection.push upstreams...
             .catch $log.error
         containment: 'ion-view'

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
