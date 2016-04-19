angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'

app = require('angular').module('mydoglacy', [
  require 'angular-ui-router'
  require 'angular-sanitize'
  require 'angular-resource'
  'ngAnimate'
  'duScroll'
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
  'ui.bootstrap'
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
require './edit_modal'
require './sections'

app.run [
  '$rootScope'
  (
    $rootScope
  ) ->

]
