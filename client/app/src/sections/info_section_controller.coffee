module.exports = [
  '$scope'
  'lodash'
  'PageService'
  (
    $scope
    _
    PageService
  ) ->
    $scope.name = PageService.pet.name

    $scope.$on 'save page.info', ->
      PageService.pet.name = $scope.name

    return this

]
