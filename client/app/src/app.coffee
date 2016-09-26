angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'
require '../../node_modules/textangular/dist/textAngular-rangy.min'
require '../../node_modules/textangular/dist/textAngular-sanitize.min'
require '../../node_modules/textangular/dist/textAngular.min'
require 'ng-file-upload'
require 'angular-confirm'
require 'angular-deckgrid'
require '@iamadamjowett/angular-click-outside'
require 'angular-inview'

require 'autotrack'

app = require('angular').module('mydoglacy', [
  require 'angular-ui-router'
  require 'angular-resource'
  'angular-click-outside'
  'ngAnimate'
  'textAngular'
  'duScroll'
  'angular.filter'
  'ngFileUpload'
  'LocalStorageModule'
  'ngLodash'
  'ui.bootstrap'
  'angular-confirm'
  'akoenig.deckgrid'
  'angular-inview'
  require 'angular-moment'
])

app.factory 'AuthorizationInterceptor', require './authorization_interceptor'
app.service 'TokenService', require './token_service'
app.service 'PetService', require './pet_service'
app.service 'SecurityService', require './security_service'
app.controller 'HollaBackCtrl', require './holla_back_controller'

app.config require './routes'
app.config [
  'localStorageServiceProvider'
  (
    localStorageServiceProvider
  ) ->

    localStorageServiceProvider
      .setPrefix 'mydoglacy'
]
app.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push 'AuthorizationInterceptor'
]

require './main'
require './page'
require './pets'
require './password_reset'
require './password_forgot'
require './account_verify'
require './privacy_policy'
require './terms_of_service'
require './services'

app.constant 'API_PATH', 'http://localhost:8081'
app.constant 'HOLLA_BACK_PATH', 'http://localhost:8082'
app.constant 'HOLLA_BACK_APP_ID', '57e94f3efaf1ad3068bdbb36'

app.run [
  '$rootScope'
  '$http'
  '$state'
  'UserService'
  'TokenService'
  'API_PATH'
  'localStorageService'
  (
    $rootScope
    $http
    $state
    UserService
    TokenService
    API_PATH
    localStorageService
  ) ->

    page = localStorageService.get 'page'
    if page? and page._id? and page.activeUntil?
      localStorageService.remove 'page'

    if TokenService.getToken()?
      user = UserService.getUser()
      if user?
        UserService.get user._id
          .catch (err) ->
            TokenService.setToken null
            console.log 'we are forcing the user to main..'
            $state.go 'main'

]
