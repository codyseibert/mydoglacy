module.exports = [
  '$scope'
  '$rootScope'
  'lodash'
  'PageService'
  'localStorageService'
  (
    $scope
    $rootScope
    _
    PageService
    localStorageService
  ) ->

    $scope.page = PageService
    $scope.currentSection = 0

    $scope.$on 'closeEditModal', ->
      $scope.showEditModal = false

    $scope.$watch ->
      PageService
    , ->
      $scope.page = PageService
      localStorageService.set 'page', PageService
    , true

    $scope.showEditModal = true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.showEditModal = true

    $scope.publish = ->
      $rootScope.STRIPE.open(
        name: "Publish #{$scope.page.pet.name}'s Page",
        description: "Pay to make #{$scope.page.pet.name}'s page live"
        amount: 999
      )

    $scope.slides = []
    for image, i in PageService.carousel
      $scope.slides.push
        id: i
        image: image
        title: 'Testing'
        description: 'testing'


    return this

]
