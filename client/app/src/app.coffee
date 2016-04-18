angular = require 'angular'
require 'angular-scroll'
require 'angular-chart.js'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'

app = require('angular').module('typr', [
  require 'angular-ui-router'
  require 'angular-sanitize'
  require 'angular-bootstrap-npm'
  require 'angular-resource'
  'ngAnimate'
  'duScroll'
  'chart.js'
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
  require 'angular-moment'
])
app.config require './routes'
app.config [
  'ChartJsProvider'
  'localStorageServiceProvider'
  (
    ChartJsProvider
    localStorageServiceProvider
  ) ->
    ChartJsProvider.setOptions
      animation: false
      showTooltips: false

    localStorageServiceProvider
      .setPrefix 'mydoglacy'
]
require './about'
require './main'

app.run [
  'LoginService'
  '$rootScope'
  (
    LoginService
    $rootScope
  ) ->
    LoginService.verify()

    $rootScope.isLoggedIn = ->
      LoginService.isLoggedIn()
]
