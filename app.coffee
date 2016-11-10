express = require 'express'
path = require 'path'
mysql = require 'mysql'

# connection = mysql.createConnection
#   host: 'localhost',
#   user: 'root',
#   password: '',
#   database: 'todo_backbone'
#
# connection.connect (err)->
#   if err
#     console.log err
#     throw err
#   console.log 'you are now connected'
#   return
#
# queryString = 'SELECT * FROM todos'

app = express()

app.get '/', (req, res)->
  res.sendFile(path.join(__dirname + '/index.html'))
  return

app.use('/node_modules', express.static(__dirname + '/node_modules'))
app.use('/js', express.static(__dirname + '/js'))
app.use('/css', express.static(__dirname + '/css'))

app.listen 2020

console.log 'Running on port 2020'
