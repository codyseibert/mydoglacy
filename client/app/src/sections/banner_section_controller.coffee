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

    return this

]
