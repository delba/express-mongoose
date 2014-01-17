path = require 'path'

express = require 'express'
engines = require 'consolidate'

app = express()

app.engine 'eco', engines.eco

app.set 'view engine', 'eco'
app.set 'uploads', path.join(__dirname, 'public', 'uploads')

app.use express.favicon()
app.use express.static('public')
app.use express.bodyParser()
app.use express.methodOverride()

if 'development' is app.get('env')
  app.use express.logger('dev')

PhotosController = require './controllers/photos_controller'

app.get    '/',    PhotosController.index
app.get    '/new', PhotosController.new
app.get    '/:id', PhotosController.show
app.post   '/',    PhotosController.create
app.delete '/:id', PhotosController.destroy

app.listen 3000
