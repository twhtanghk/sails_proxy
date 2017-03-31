module.exports =
  routes:
    'GET /upstream':
      controller: 'Upstream'
      action: 'find'
      sort: 'order ASC'

    'POST /upstream':
      controller: 'Upstream'
      action: 'create' 

    'PUT /upstream/reorder':
      controller: 'Upstream'
      action: 'reorder'

    'PUT /upstream/:id':
      controller: 'Upstream'
      action: 'update' 

    'DELETE /upstream/:id':
      controller: 'Upstream'
      action: 'destroy' 

     'GET /upstream/photo/:id':
      controller: 'Upstream'
      action: 'getPhoto'  
