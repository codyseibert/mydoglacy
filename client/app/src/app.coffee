angular = require 'angular'
require 'angular-scroll'
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
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
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

app.run [
  '$rootScope'
  (
    $rootScope
  ) ->

]
