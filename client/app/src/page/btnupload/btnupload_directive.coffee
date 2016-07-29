module.exports = [
  '$rootScope'
  'Upload'
  (
    $rootScope
    Upload
  ) ->

    restrict: 'E'

    scope:
      save: '&'
      image: '=?'
      onUpload: '=?'

    link: (scope, elem, attr) ->
      scope.image ?= ''
      
      scope.upload = (file) ->
        scope.uploading = true
        scope.image = 'assets/images/uploading.gif'
        Upload.upload(
          url: 'http://localhost:8081/images'
          data:
            file: file
        )
          .then (resp) ->
            scope.uploading = false
            scope.image = resp.data
            scope.save()
            scope.onUpload? resp.data
          , (resp) ->
            console.log 'Error', resp
          , (evt) ->
            # scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    templateUrl: 'page/btnupload/btnupload.html'

]
