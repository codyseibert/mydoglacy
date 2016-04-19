module.exports = [
  '$scope'
  'lodash'
  (
    $scope
    _
  ) ->

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
