module.exports = [
  '$scope'
  'lodash'
  'PageService'
  'Upload'
  'API_PATH'
  (
    $scope
    _
    PageService
    Upload
    API_PATH
  ) ->

    $scope.name = PageService.pet.name
    $scope.uploading = false
    $scope.percent = 0
    $scope.done = false

    $scope.$on 'save page.banner', ->
      # do something...

    $scope.upload = (file) ->
      $scope.uploading = true
      Upload.upload(
        url: "#{API_PATH}/images"
        data:
          file: file
      )
        .then (resp) ->
          $scope.uploading = false
          $scope.done = true
          PageService.banner = resp.data
        , (resp) ->
          console.log 'Error', resp
        , (evt) ->
          $scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    return this

]
