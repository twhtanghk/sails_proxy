module.exports =
  policies:
    UpstreamController:
      '*': false
      'find': true
      'create': ['isAuth', 'isAdmin', 'setCreatedBy']
      'update': ['isAuth', 'isAdmin', 'setUpdatedBy']
      'destroy': ['isAuth', 'isAdmin']
      'reorder': ['isAuth', 'isAdmin', 'setUpdatedBy']
