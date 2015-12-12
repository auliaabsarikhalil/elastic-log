## Elastic Log
This is a Service for saving your log into elastic search and analyze it with Kibana

## Setup

Everything you need to setup before run the code:

1. [Setup Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html)
2. [Setup Kibana](https://www.elastic.co/guide/en/kibana/current/setup.html)
3. Install all required modules : `npm install`
4. Setup app config at `.msConfig.coffee`
5. Create `.env` file (just copy .env.example file and remove `.example`) and define your environment

```coffeescript

module.exports =
	# choose based on your env
	common:
		elasticSearch:
		  	index : 'logs'
		  	host : "localhost:9200"
		  	log : 'trace'
``` 

## How to test
run : `npm test`

## Debug Mode
You can run in Debug Mode : `DEBUG=elastic coffee index.coffee`

## How to use it
1. [Start Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html)
2. Run app : `coffee index.coffee`
3. send data to `HOST:1503/send`, data example:

```json
{
    "status": "success",
    "message" : "Data has been created",
    "origin" : "api",
    "type":"email",
    "request":{"origin":"api", "type":"email", "target":{"email":"aulia@example.com"} }
}

```

## Analyze Data
You can analyze the data with [Kibana](https://www.elastic.co/guide/en/kibana/current/index.html)