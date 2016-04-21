module.exports = [
  '$scope'
  '$window'
  'lodash'
  'PageService'
  'Upload'
  (
    $scope
    $window
    _
    PageService
    Upload
  ) ->

    $scope.name = PageService.pet.name
    $scope.carousel = PageService.carousel
    $scope.uploading = false
    $scope.percent = 0

    $scope.$on 'save page.carousel', ->
      PageService.carousel = $scope.carousel
      # do something...

    $scope.delete = (carousel) ->
      $scope.carousel.splice $scope.carousel.indexOf(carousel), 1

    $scope.upload = (file) ->
      $scope.uploading = true
      Upload.upload(
        url: 'http://localhost:8081/images'
        data:
          file: file
      )
        .then (resp) ->
          $scope.uploading = false
          $scope.carousel.push resp.data
          console.log $scope.carousel
        , (resp) ->
          console.log 'Error', resp
        , (evt) ->
          $scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    return this

]
