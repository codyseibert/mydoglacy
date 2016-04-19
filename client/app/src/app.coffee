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


app = require('angular').module('mydoglacy', [
  require 'angular-ui-router'
  require 'angular-resource'
  'ngAnimate'
  'textAngular'
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
