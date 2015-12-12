module.exports =
	common:
		port: 1503
		host:"localhost"
		elasticSearch:
			index : 'logs'
			host : "localhost:9200"
			log : 'trace'

	development:
		port: 1503
		host:"localhost"
		elasticSearch:
			index : 'logs'
			host : "localhost:9200"
			log : 'trace'

	production:
		port: 1503
		host:"localhost"
		elasticSearch:
			index : 'YOUR_INDEX'
			host : "YOUR_HOST"
			log : 'YOUR_LOG'