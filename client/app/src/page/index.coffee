app = require('angular').module 'mydoglacy'

app.controller 'PageCtrl', require './page_controller'
app.service 'PageService', require './page_service'
app.directive 'btnedit', require './btnedit/btnedit_directive'
app.directive 'btnupload', require './btnupload/btnupload_directive'
