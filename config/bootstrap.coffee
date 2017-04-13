_ = require 'lodash'

module.exports =
  bootstrap: (done) ->
    sails.io.httpServer.on 'upgrade', (req, socket, head) ->
      _.map sails.models.upstream.wsProxy, (proxy, prefix) ->
        if req.url.indexOf(prefix) == 0
          req.url = req.url.slice (prefix.length - 1)
          sails.log.debug req.url
          return proxy.upgrade req, socket, head
    sails.models.upstream.reload()
      .then done
      .catch done
