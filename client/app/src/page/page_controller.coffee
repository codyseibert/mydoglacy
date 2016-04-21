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

    $scope.slides = [
      id: 0
      image: 'assets/images/grayhound.jpg'
      title: 'Grayhound'
      description: 'This was some random stock photo =P'
    ,
      id: 1
      image: 'assets/images/bg.jpg'
      title: 'Horse'
      description: 'This was some random stock photo =P'
    ]

    return this

]
