require 'angular-activerecord'
_ = require 'lodash'

angular.module 'starter.model', ['ActiveRecord']
  .factory 'resource', (ActiveRecord, $window, $log) ->

    class Model extends ActiveRecord
      org: {}

      constructor: (attrs = {}, opts = {}) ->
        @$initialize attrs, opts
        @backup()

      # keep existing values in org
      backup: ->
        _.extend @org, _.omit(@, 'org')

      # restore org values to exsiting values
      restore: ->
        _.extend @, @org

      $save: (values, opts) ->
        super values, opts
          .then (model) =>
            @backup()
            model
          .catch (err) =>
            @restore()
            Promise.reject err
      
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

      go: ->
        $window.open @prefix.replace(/^\//g, ''), '_blank'
        return false

      @reorder = (upstreams) ->
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
