_ = require 'lodash'
path = require 'path'
req = require 'supertest-as-promised'

describe 'UpstreamController', ->
  @timeout 500000
	
  _.each ['app1', 'app2'], (app) ->
    it "create upstream #{app}", ->
      req sails.hooks.http.app 
        .post "/upstream"
        .set 'Content-Type', 'application/json'
        .set 'x-forwarded-email', 'admin@mob.myvnc.com'
        .send prefix: "/#{app}", target: "http://#{app}.service.consul:1337"
        .expect 201

  it "get upstream", ->
    req sails.hooks.http.app 
      .get "/upstream"
      .expect 200
      .then (res) ->
        sails.log.info res.body

  it "put upstreams", ->
    sails.models.upstream
      .find()
      .then (apps) ->
        Promise.all _.map apps, (app) ->
          req sails.hooks.http.app 
            .put "/upstream/#{app.id}"
            .set 'Content-Type', 'application/json'
            .set 'x-forwarded-email', 'admin@mob.myvnc.com'
            .send 
               prefix: "#{app.prefix}_v2"
            .expect 200

  it "get upstream", ->
    req sails.hooks.http.app
      .get "/upstream"
      .expect 200
      .then (res) ->
        sails.log.info res.body

  it "delete upstreams", ->
    sails.models.upstream
      .find()
      .then (apps) ->
        Promise.all _.map apps, (app) ->
          req sails.hooks.http.app
            .delete "/upstream/#{app.id}"
            .set 'Content-Type', 'application/json'
            .set 'x-forwarded-email', 'admin@mob.myvnc.com'
            .send prefix: "/#{app}"
            .expect 200

  it "get upstream", ->
    req sails.hooks.http.app
      .get "/upstream"
      .expect 200
      .then (res) ->
        sails.log.info res.body
