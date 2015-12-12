Settings  = require 'settings'
env       = require './.env'
config    = new Settings(require('./.msConfig'), { env : env })

module.exports = config