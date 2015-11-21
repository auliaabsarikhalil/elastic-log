## Elastic Log
Sample code to save your data to Elastic Search

## Setup

Everything you need to setup before run the code:

1. [Setup Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html)
2. [Setup Kibana](https://www.elastic.co/guide/en/kibana/current/setup.html)
3. Install all required modules : `npm install`
4. Setup app config at `.config.coffee`

```coffeescript

module.exports =
	elasticSearch:
	  	index : 'logs'
	  	host : "localhost:9200"
	  	log : 'trace'

``` 

## How to test
run : `npm test`

## How to use it
1. [Start Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html)
2. Run app : `coffee index.coffee`
3. You can analyze the data with [Kibana](https://www.elastic.co/guide/en/kibana/current/index.html)
4. You can run in Debug Mode : `DEBUG=elastic coffee index.coffee`