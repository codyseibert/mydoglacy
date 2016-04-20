module.exports = [
  '$scope'
  'lodash'
  'PageService'
  'Upload'
  (
    $scope
    _
    PageService
    Upload
  ) ->

    $scope.name = PageService.pet.name
    $scope.uploading = false
    $scope.percent = 0

    $scope.$on 'save page.banner', ->
      # do something...

    $scope.upload = (file) ->
      $scope.uploading = true
      Upload.upload(
        url: 'http://localhost:8081/images'
        data:
          file: file
      )
        .then (resp) ->
          $scope.uploading = false
          PageService.banner = resp.data
        , (resp) ->
          console.log 'Error', resp
        , (evt) ->
          $scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    return this

]
