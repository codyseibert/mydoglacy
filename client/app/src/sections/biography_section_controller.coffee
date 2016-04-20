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
    $scope.biography = PageService.biography

    $scope.$on 'save page.biography', ->
      PageService.biography = $scope.biography
      # TODO: Persist

    return this

]
