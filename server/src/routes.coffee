app = require './app'
UsersCtrl = require './controllers/users_controller'
ObituariesCtrl = require './controllers/obituaries_controller'
ImagesCtrl = require './controllers/images_controller'

userIsLoggedIn = require './helpers/user_is_logged_in'
userOwnsObituary = require './helpers/user_owns_obituary'

multer = require 'multer'
upload = multer dest: '/tmp'

module.exports = do ->
  app.get '/users/:id', userIsLoggedIn, UsersCtrl.show
  app.post '/users', UsersCtrl.post
  app.put '/users/:id', userIsLoggedIn, UsersCtrl.put

  app.get '/obituaries/:id', ObituariesCtrl.show
  app.post '/obituaries', ObituariesCtrl.post
  app.put '/obituaries/:id', userOwnsObituary, ObituariesCtrl.put

  app.post '/images', upload.single('file'), ImagesCtrl.post
