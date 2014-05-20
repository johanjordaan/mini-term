fs = require('fs')
_ = require('underscore')

express = require('express')
bodyParser = require('body-parser')

app = express()

app.use bodyParser()
app.use(express.static('bower_components'))
app.use(express.static('dist'))
app.use(express.static('examples'))


app.get '/(.*)', (req, res) ->

  console.log req.params
  
  fs.readFile 'index.html',(err,data) ->
    if err
      res.send 'Cannot read file'
    else
      res.set {'Content-Type': 'text/html'}
      res.send data

server = app.listen(3000)

if module?
  module.exports.server = server