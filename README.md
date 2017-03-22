# sails_proxy
Reverse http proxy with rest API runtime configuration

## Configuration

1. Configured by environment variables in [.env](https://github.com/twhtanghk/sails_proxy/blob/master/.env)
2. Assume default upstream [echo](http://github.com/solsson/docker-http-echo) on http://echo

## Start sails_proxy
### run by docker compose (preferred way to start required services mongo, echo, sails_proxy)
1. download '.env' and customize env variables if required
2. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up

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
3. press /prefix or http://echo to update upstream details
4. drag and drop the upstream apps to redefine the upstream apps order
5. swipe left and press Delete button to delete the upstream app
6. browse http://host:1337/echo/test to view proxy request details for the default echo app
