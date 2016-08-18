module.exports =
  routes:
    'GET /upstream':
      controller: 'Upstream'
      action: 'find'
      sort: 'order ASC'

    'POST /upstream':
      controller: 'Upstream'
      action: 'create' 

    'PUT /upstream/:id':
      controller: 'Upstream'
      action: 'update' 

    'PUT /upstream/reorder':
      controller: 'Upstream'
      action: 'reorder'

    'DELETE /upstream/:id':
      controller: 'Upstream'
      action: 'destroy' 
