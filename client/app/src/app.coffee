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

ga 'create', 'UA-77135326-2', 'auto'

ga 'require', 'cleanUrlTracker'
ga 'require', 'eventTracker'
ga 'require', 'urlChangeTracker'

ga 'send', 'pageview'

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

app.constant 'API_PATH', 'http://localhost:8081'

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
            $state.go 'main'

]
