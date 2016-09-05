shuffle = require 'shuffle-array'
$ = require 'jquery'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  'lodash'
  'PageService'
  'localStorageService'
  'Upload'
  'API_PATH'
  (
    $scope
    $rootScope
    $interval
    _
    PageService
    localStorageService
    Upload
    API_PATH
  ) ->

    $scope.page = PageService
    $scope.page.layouts =
      main: 0
    $scope.currentSection = 0
    $scope.isEditMode = false
    $scope.showModal = true
    $scope.currentStep = 0

    $scope.editing =
      name: false

    $scope.editItem = (key) ->
      return if not $scope.isEditMode
      $scope.editing[key] = true

    $scope.$on 'closeEditModal', ->
      $scope.showEditModal = false

    $scope.hideModal = ->
      $scope.showModal = false
      $scope.currentStep = 1

    $scope.$watch ->
      PageService
    , ->
      $scope.page = PageService
      localStorageService.set 'page', PageService
    , true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.isEditMode = not $scope.isEditMode
      $scope.currentStep = 2

    $scope.publish = ->
      $rootScope.STRIPE.open(
        name: "Publish #{$scope.page.pet.name}'s Page",
        description: "Pay to make #{$scope.page.pet.name}'s page live"
        amount: 999
      )

    $scope.cardClicked = (card) ->
      console.log card

    $scope.save = ->
      console.log 'saving'

    $scope.onSlideUpload = (image) ->
      $scope.page.carousel.push
        image: image
        title: 'Testing'
        description: 'testing'
      $scope.slide = $scope.page.carousel[$scope.page.carousel.length - 1]

    $scope.delete = (slide) ->
      return if not confirm 'Are you sure you want to delete this image?'
      $scope.page.carousel.splice $scope.page.carousel.indexOf(slide), 1
      gotoNextSlide()

    $scope.upload = (file, obj, key) ->
      obj[key] = 'assets/images/uploading.gif'
      Upload.upload(
        url: "#{API_PATH}/images"
        data:
          file: file
      )
        .then (resp) ->
          obj[key] = resp.data
        , (resp) ->
          console.log 'Error', resp
        , (evt) ->
          # scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    return this

]
