module.exports = [
  '$scope'
  'lodash'
  'PageService'
  (
    $scope
    _
    PageService
  ) ->

    $scope.page = PageService
    $scope.currentSection = 0

    $scope.$on 'closeEditModal', ->
      $scope.showEditModal = false

    $scope.$watch ->
      PageService
    , ->
      $scope.page = PageService
    , true

    $scope.showEditModal = true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.showEditModal = true

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
