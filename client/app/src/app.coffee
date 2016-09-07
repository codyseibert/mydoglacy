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
  'PageService'
  'UserService'
  'API_PATH'
  (
    $rootScope
    $http
    PageService
    UserService
    API_PATH
  ) ->

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      $rootScope.STRIPE.close()

    # TODO: Does this need to be in rootScope?
    $rootScope.STRIPE = StripeCheckout.configure(
      key: 'pk_test_VSOl2a32ywHvrzNjzQfxTFBD'
      locale: 'auto'
      token: (token) ->
        $rootScope.$emit 'charge.started'
        $http.post "#{API_PATH}/charge", {stripeToken: token, page: PageService, email: UserService.getUser().email}
          .then (res) ->
            $rootScope.$emit 'charge.success', res.data
          .catch (err) ->
            $rootScope.$emit 'charge.failure'
    )
]
