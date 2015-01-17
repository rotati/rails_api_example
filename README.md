# README

## Setting up dev

Edit your `/etc/hosts` file to map 127.0.0.1 (localhost) to the api subdomain of the development domain like so:

`127.0.0.1 localhost api.estate-dev.com`

Now, start the Rails server open your browser at [http://api.estate-dev.com:3000](http://api.estate-dev.com:3000) and you should see the Rails welcome page.

## Testing the API using CURL

### GET /properties (HTTP Headers only)

`curl -I http://api.estate-dev.com:3000/properties/`

### GET /properties (default JSON format)

`curl http://api.estate-dev.com:3000/properties`

### GET /properties/:id

`curl http://api.estate-dev.com:3000/properties/1`

### GET /properties/ (in XML format)

`curl -H "Accept: application/xml" http://api.estate-dev.com:3000/properties`

### POST /properties

`curl -i -X POST -d 'property[name]=Dadouland;property[province]=Kandel' http://api.estate-dev.com:3000/properties`
