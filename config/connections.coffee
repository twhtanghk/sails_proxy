module.exports = 
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: 'mongodb://@mongo.service.consul:27017/proxy'
