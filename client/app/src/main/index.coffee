app = require('angular').module 'mydoglacy'

app.controller 'MainCtrl', require './main_controller'
app.directive 'scrollPosition', require './scroll_position_directive'
