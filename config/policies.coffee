module.exports =
  policies:
    UpstreamController:
      '*': false
      'find': true
      'create': ['isAuth', 'setCreatedBy']
      'update': ['isAuth', 'setUpdatedBy']
      'destroy': ['isAuth']
      'reorder': ['isAuth', 'setUpdatedBy']
