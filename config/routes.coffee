module.exports =
  routes:
    'GET /upstream':
      controller: 'Upstream'
      action: 'find'
      sort: 'order ASC'

    'POST /upstream':
      controller: 'Upstream'
      action: 'create' 

    'PUT /upstream':
      controller: 'Upstream'
      action: 'update' 

    'DELETE /upstream':
      controller: 'Upstream'
      action: 'destroy' 
