shuffle = require 'shuffle-array'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  'lodash'
  'PageService'
  'localStorageService'
  (
    $scope
    $rootScope
    $interval
    _
    PageService
    localStorageService
  ) ->

    $scope.page = PageService
    $scope.page.layouts =
      main: 0
    $scope.currentSection = 0
    currentSlide = 0
    SLIDE_INTERVAL = 5000
    $scope.isEditMode = true

    # shuffle $scope.page.carousel

    $scope.editing =
      name: false

    $scope.$on 'closeEditModal', ->
      $scope.showEditModal = false

    $scope.$watch ->
      PageService
    , ->
      $scope.page = PageService
      localStorageService.set 'page', PageService
    , true

    # $scope.showEditModal = true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.isEditMode = not $scope.isEditMode

    $scope.publish = ->
      $rootScope.STRIPE.open(
        name: "Publish #{$scope.page.pet.name}'s Page",
        description: "Pay to make #{$scope.page.pet.name}'s page live"
        amount: 999
      )

    $scope.save = ->
      console.log 'saving'

    $scope.onSlideUpload = (image) ->
      $scope.page.carousel.push
        image: image
        title: 'Testing'
        description: 'testing'
      $scope.slide = $scope.page.carousel[$scope.page.carousel.length - 1]

    gotoNextSlide = ->
      return if $scope.page.carousel.length is 0
      currentSlide = (currentSlide + 1) % $scope.page.carousel.length
      $scope.slide = $scope.page.carousel[currentSlide]

    $interval ->
      gotoNextSlide()
    , SLIDE_INTERVAL

    $scope.next = ->
      gotoNextSlide()

    $scope.delete = (slide) ->
      return if not confirm 'Are you sure you want to delete this image?'
      $scope.page.carousel.splice $scope.page.carousel.indexOf(slide), 1
      gotoNextSlide()

    $scope.previous = ->
      currentSlide -= 1
      currentSlide = $scope.page.carousel.length - 1 if currentSlide < 0
      $scope.slide = $scope.page.carousel[currentSlide]

    return this

]
