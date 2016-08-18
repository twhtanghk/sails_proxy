# sails_proxy
Reverse proxy with rest API runtime configuration

## Configuration

1. Configured by environment variables in [.env](https://github.com/twhtanghk/sails_proxy/blob/master/.env)
2. Default upstream [http-echo-server](https://github.com/watson/http-echo-server) confgiured on next available port (default: env.PORT + 1)

## Start sails_proxy
### run as node application
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
4. setup mongo database server with default host proxy_mongo and port 27017
```
npm config set user root # if run by docker
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

### run by docker compose (preferred way to start reqired services mongo, echo, sails_proxy)
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
4. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up

# remove environment variable NODE_ENV=development defined in docker-compose.yml to start services with oauth2 protection
```

## API
1. [upstream data](https://github.com/twhtanghk/sails_proxy/blob/master/api/models/Upstream.coffee)
2. 'GET /upstream' to return full list of upstream apps
3. 'POST /upstream' to create upstream app with prefix and target
4. 'PUT /upstream/:id' to update upstream app details
5. 'PUT /upstream/reorder' to reorder upstream apps in the input order [id1, id2, ...]
6. 'DELETE /upstream/:id' to delete the specified upstream app

## Usage
1. browse http://host:1337 to view defined upstream apps
2. press New button to create upstream apps
3. press /prefix or http://target:80 to update upstream details
4. drag and drop the upstream apps to redefine the upstream apps order
5. swipe left and press Delete button to delete the upstream app
6. browse http://host:1337/echo/test to view proxy request details for the default echo app
