elastic = require '../elastics/elastic'
config = require '.config'

status 	= ['success', 'error']
now 	= new Date()
now 	= now.toISOString()
index 	= Math.round(Math.random()*10%1)

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
	index : config.elasticSearch.index
	type : if msg.origin then msg.origin  else "data-error"
	body : msg

elastic.createData data, (err, response) ->
	
	if err
		console.dir err
		return

	console.dir response