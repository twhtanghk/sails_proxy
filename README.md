# oauth2_code
Reverse proxy with rest API runtime configuration

## Configuration

### Configured by environment variables in [.env](https://github.com/twhtanghk/sails_proxy/blob/master/.env)

### Default upstream [http-echo-server](https://github.com/watson/http-echo-server) confgiured on next available port (default: env.PORT + 1)

## Start sails_proxy
### run as node application
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
4. setup mongo database server with default host proxy_mongo and port 27017
```
npm install sails_proxy -g
set -a; . .env; set +a
env NODE_ENV=development sails_proxy
```
### run docker image
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
4. setup mongo database server with default host proxy_mongo and port 27017
```
docker run --name sails_proxy --env-file .env -p 1337:1337 -v /path/upstream.coffee:/usr/src/app/config/env/upstream.coffee -d twhtanghk/sails_proxy
```

### run by docker compose
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
4. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up
```
