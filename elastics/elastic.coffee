config = require '../.config'
debug = require('debug')('elastic')
elasticsearch = require 'elasticsearch'
generalLogMapping = require './mappings/general_log_mapping'

client = new elasticsearch.Client host: config.elasticSearch.host

module.exports =

	ping : (cb) -> 

		debug 'ping elastic host'

		data = 
			requestTimeout : Infinity,
			hello : 'elasticsearch'

		client.ping data, (error, response) ->
			return cb "Fail to connect" if error
			return cb null, "success"
 
	checkIndexExists : (index, cb) ->

		self = @
		
		data =
			index : index

		debug 'Check if index exist'

		client.indices.exists data, (error, response) ->

			return cb error if error

			if response is true
				return cb null, response

			self.createIndex index, (error, response) ->
				return cb error if error
				return cb null, response 

	checkTypeExists : (index, type, cb) ->
		
		data =
			index : index
			type : type

		debug 'Check if type exists'

		client.indices.existsType data, (error, response) ->

			return cb error if error

			if response is true	
				return cb null, response
			
			debug 'Type is not exists, begin to create mapping'

			generalLogMapping.initMapping index, type, (error, response) ->
				return cb error if error 
				return cb null, response
			
	createIndex : (index, cb) ->
		
		debug 'Create Index'

		data = 
			index : index

		client.indices.create data, (error, response) ->

			return cb if error
			return cb null, response

	checkIndexAndType : (index, type, cb) ->

		debug 'Check index and type'

		self = @

		self.checkIndexExists index, (error, response) ->
			
			return cb error if error
			
			self.checkTypeExists index, type, (error, response) ->
				return cb error if error
				return cb null, response

	createData : (data, cb) ->
		
		self = @

		self.checkIndexAndType data.index, data.type, (error, response) ->
			return cb error if error

			debug 'Begin to save data to elastic'
			
			client.create data, (error, response) ->
				return cb error if error
				return cb null, response