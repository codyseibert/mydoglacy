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

    $scope.closeEditModal = ->
      console.log 'emit'
      $scope.$emit 'closeEditModal'

    return this

]
