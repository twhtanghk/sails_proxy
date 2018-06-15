module.exports =
  admin: process.env.ADMIN?.split(',') || [
    'admin@abc.com'
  ]
  oauth2:
    url:
      authorize: process.env.AUTHURL || 'https://abc.com/auth/oauth2/authorize/'
      verify: prociess.env.VERIFYURL || 'https://abc.com/auth/oauth2/verify/'
      token: 'https://abc.com/auth/oauth2/token/'
    client:
      id: 'process.env.CLIENT_ID || client_id'
      secret: 'client_secret'
    user:
      id: 'user_id'
      secret: 'user_secret'
