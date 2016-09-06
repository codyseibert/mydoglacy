app = require './app'
UsersCtrl = require './controllers/users_controller'
PetsCtrl = require './controllers/pets_controller'
ImagesCtrl = require './controllers/images_controller'
ChargeCtrl = require './controllers/charge_controller'
LoginCtrl = require './controllers/login_controller'

userIsLoggedIn = require './helpers/user_is_logged_in'
userOwnsPet = require './helpers/user_owns_pet'

multer = require 'multer'
upload = multer dest: '/tmp'

module.exports = do ->
  app.get '/users/:id', userIsLoggedIn, UsersCtrl.show
  app.post '/users', UsersCtrl.post
  app.put '/users/:id', userIsLoggedIn, UsersCtrl.put

  app.get '/pets/:id', PetsCtrl.show
  app.post '/pets', PetsCtrl.post
  app.put '/pets/:id', userOwnsPet, PetsCtrl.put

  app.post '/images', upload.single('file'), ImagesCtrl.post

  app.post '/charge', ChargeCtrl.post

  app.post '/login', LoginCtrl.post
