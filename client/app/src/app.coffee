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
  require 'angular-moment'
])
app.config require './routes'
app.config [
  'localStorageServiceProvider'
  (
    localStorageServiceProvider
  ) ->

    localStorageServiceProvider
      .setPrefix 'mydoglacy'
]

require './main'
require './page'

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

    $rootScope.STRIPE = StripeCheckout.configure(
      key: 'pk_test_VSOl2a32ywHvrzNjzQfxTFBD'
      locale: 'auto'
      token: (token) ->
        console.log 'token', token
        $http.post "#{API_PATH}/charge", {stripeToken: token, page: PageService, email: UserService.email}
          .then (res) ->
            console.log 'res', res
          .catch (err) ->
            console.log 'err', err
    )
]
