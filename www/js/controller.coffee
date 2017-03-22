_ = require 'lodash'
path = require 'path'
require './model.coffee'

angular.module 'starter.controller', ['starter.model', 'ionic']
  .controller 'UpstreamsCtrl', ($scope, resource) ->
    collection = []
    resource.Upstream.fetchAll()
      .then (res) ->
        _.merge collection, res
    _.extend $scope, 
       collection: collection
       create: ->
         upstream = new resource.Upstream()
         upstream
           .$save()
           .then ->
             collection.push upstream
       drag:
         orderChanged: (event) ->
           itemScope = event.source.itemScope
           sortableScope = event.dest.sortableScope
           selected = itemScope.model

           neworder = _.map $scope.collection, (model) ->
             model.id
           _.remove neworder, (id) ->
             id == selected.id
           neworder.splice event.dest.index, 0, selected.id

           resource.Upstream
             .reorder neworder
             .then (upstreams) ->
               $scope.collection.length = 0
               $scope.collection.push upstreams...
             .catch ->
               sortableScope.removeItem event.dest.index
               itemScope.sortableScope.insertItem event.source.index, selected
         containment: 'ion-content'

  .controller 'UpstreamCtrl', ($scope) ->
    _.extend $scope,
      update: (values) ->
        $scope.model
          .$save values
          .then ->
            return true
          .catch ->
            return false
      destroy: ->
        id = $scope.model.id
        $scope.model
          .$destroy()
          .then ->
            _.remove $scope.collection, (model) ->
              model.id == id
