config = require '../../.config'
elasticsearch = require 'elasticsearch'

client = new elasticsearch.Client { host: config.elasticSearch.host}

module.exports = 

	initMapping : (index, type, cb) ->
		
		properties =
			properties :
				status :
					type : "string"
				message:
					type:"string"
				origin :
					type : "string"
				request :
					properties :
						origin :
							type : "string"
				date :
					type : "date"
				_timestamp : 
		            enabled : true

		data = 
			index : index
			type : type
			body : properties

		client.indices.putMapping data, (error, response) ->
			
			return cb error if error			
			return cb null, response