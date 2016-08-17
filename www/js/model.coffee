require 'angular-activerecord'
_ = require 'lodash'

angular.module 'starter.model', ['ActiveRecord']
  .factory 'resource', (ActiveRecord) ->
    class Model extends ActiveRecord
      constructor: (attrs = {}, opts = {}) ->
        @$initialize attrs, opts

    class User extends Model
      $idAttribute: 'email'

      $urlRoot: 'user'

      _me = null

      home: ->
        "/#{@name}"

      @me: ->
        _me ?= new User email: 'me'

    class Upstream extends Model
      $idAttribue: 'prefix'

      $urlRoot: 'upstream'

      @reorder = (apps) ->
        upstreams = _.map apps, (app) ->
          app.id
        ActiveRecord
          .sync 'update', {},
            url: 'upstream/reorder'
            data:
              upstreams: upstreams
          .then (res) ->
            ret = []
            _.each res.data, (upstream) ->
              ret.push new Upstream upstream
            ret

    User: User
    Upstream: Upstream
