elastic 	= require './elastics/elastic'
config 		= require './.config'
bodyParser 	= require 'body-parser'
express 	= require 'express'
app 		= express()

app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }

##########################################################################################
#
# {
#     "status": "success",
#     "message" : "Data has been created",
#     "origin" : "api",
#     "type":"email",
#     "request":{"origin":"api", "type":"email", "target":{"email":"aulia@example.com"} }
# }
#
##########################################################################################

app.post '/send', (req, res) ->

	msg = req.body
	msg.date = new Date()
	data =
		index 	: if msg.index then msg.index else config.elasticSearch.index
		type 	: if msg.origin then msg.origin  else "data-error"
		body 	: msg

	elastic.createData data, (err, response) ->
		return res.status(500).json({ status:"error", message:"#{err}"}) if err
		return res.json({status:"success", message:response})

server = app.listen config.port, config.host ,() ->
	host = server.address().address
	port = server.address().port
	console.log "Elastic Log listening at http://#{host}:#{port}"