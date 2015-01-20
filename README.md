# README

## Setting up dev

Edit your `/etc/hosts` file to map 127.0.0.1 (localhost) to the api subdomain of the development domain like so:

`127.0.0.1 localhost api.estate-dev.com`

Now, start the Rails server open your browser at [http://api.estate-dev.com:3000](http://api.estate-dev.com:3000) and you should see the Rails welcome page.

## Testing the API using CURL

### GET /properties (HTTP Headers only)

`curl -I http://api.estate-dev.com:3000/properties?version=20150116`

### GET /properties (default JSON format)

`curl http://api.estate-dev.com:3000/properties?version=20150116`

### GET /properties/:id

`curl http://api.estate-dev.com:3000/properties/1?version=20150116`

### POST /properties

`curl -i -X POST -d 'property[name]=Dadouland;property[province]=Kandel' http://api.estate-dev.com:3000/properties?version=20150116`

### GET /properties/ (in a specific representation version using 'Accept' headers)

`curl -H "Accept: application/vnd.rotati.v20150116+json" http://api.estate-dev.com:3000/properties`

### GET /properties/ (in a specific representation version using url params)

`curl http://api.estate-dev.com:3000/properties?version=20150116`

