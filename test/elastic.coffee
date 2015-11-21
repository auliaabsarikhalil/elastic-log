expect = require "expect.js"
elastic = require '../elastics/elastic'

describe 'Elastic Integration', () ->

	it 'should connect to elastic search', (done) ->

		elastic.ping (err, response) ->

			expect(err).to.eql(null)

			done()

	it 'check if index is exists', (done) ->

		index = 'logs-test'

		elastic.checkIndexExists index, (err, response) ->

			expect(err).to.eql(null)

			done()

	it 'check if index is not exists', (done) ->

		index = 'test-not-exists'

		elastic.checkIndexExists index, (err, response) ->

			expect(err).to.eql(null)

			done()

	it 'check if function checkIndexExists is error', (done) ->

		index = null

		elastic.checkIndexExists index, (err, response) ->

			expect(response).to.eql(undefined)
			
			expect(response).to.not.eql(null)

			done()

	it 'check if type is exists', (done) ->

		index = 'logs-test'

		type = 'notification_center'

		elastic.checkTypeExists index, type, (err, response) ->

			expect(err).to.eql(null)

			done()

	it 'check if type is not exists', (done) ->

		index = 'logs-test'

		type = 'not_exists'

		elastic.checkTypeExists index, type, (err, response) ->
			
			expect(err).to.eql(null)

			done()

	it 'check if function checkTypeExists is error', (done) ->

		index = 'logs-test'

		type = null

		elastic.checkTypeExists index, type, (err, response) ->
			
			expect(response).to.eql(undefined)
			
			expect(err).to.not.eql(null)

			done()

	it 'check index and type', (done) ->

		index = 'logs-test'

		type = 'notification_center'

		elastic.checkIndexAndType index, type, (err, response) ->
			
			expect(err).to.eql(null)

			done()

	it 'check if checkIndexAndType function is error', (done) ->

		index = null

		type = 'notification_center'

		elastic.checkIndexAndType index, type, (err, response) ->
			
			expect(response).to.eql(undefined)
			
			expect(err).to.not.eql(null)

			done()

	it 'check create data to elastic search', (done) ->

		status = ['success', 'error']

		now = new Date()
		
		now = now.toISOString()
		
		index = Math.round(Math.random()*10%1)

		msg =
			response : message : "success"
			status : status[index]
			origin : "notification_center"
			type : "email"
			request :
				origin : "api"
				type : "email"
				target :
					email : "alirezayahya@gmail.com"
			date : now

		data =
			index : 'logs-test'
			type : if msg.origin then msg.origin  else "data-error"
			body : msg

		elastic.createData data, (err, response) ->
			
			expect(err).to.eql(null)
			
			expect(response.created).to.eql(true)

			done()

	it 'check create data to elastic search if origin not defined', (done) ->

		status = ['success', 'error']

		now = new Date()
		
		now = now.toISOString()
		
		index = Math.round(Math.random()*10%1)

		msg =
			response : message : "success"
			status : status[index]
			type : "email"
			request :
				origin : "api"
				type : "email"
				target :
					email : "alirezayahya@gmail.com"
			date : now

		data =
			index : 'logs-test'
			type : if msg.origin then msg.origin  else "data-error"
			body : msg

		elastic.createData data, (err, response) ->
			
			expect(err).to.eql(null)
			
			expect(response.created).to.eql(true)

			done()

	it 'check if create data to elastic search error', (done) ->

		status = ['success', 'error']

		now = new Date()
		
		now = now.toISOString()
		
		index = Math.round(Math.random()*10%1)

		msg =
			response : message : "success"
			status : status[index]
			origin : undefined
			type : "email"
			request :
				origin : 'waw'
				type : "email"
				target :
					email : "alirezayahya@gmail.com"
			date : now

		data =
			index : 'logs-test'
			type : msg.origin
			body : msg

		elastic.createData data, (err, response) ->

			expect(err).to.not.eql(null)
			
			expect(response).to.eql(undefined)
			
			done()