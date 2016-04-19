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

    $scope.breed = PageService.pet.breed
    $scope.gender = PageService.pet.gender
    $scope.date_of_birth = PageService.pet.date_of_birth
    $scope.date_of_rest = PageService.pet.date_of_rest

    $scope.breeds = [
      name: 'Rottweiler'
      value: 'rottweiler'
    ,
      name: 'poodle'
      value: 'poodle'
    ]

    $scope.genders = [
      name: 'Male'
      value: 'male'
    ,
      name: 'Female'
      value: 'female'
    ]

    $scope.$on 'save page.details', ->
      PageService.pet.breed = $scope.breed
      PageService.pet.gender = $scope.gender
      PageService.pet.date_of_birth = $scope.date_of_birth
      PageService.pet.date_of_rest = $scope.date_of_rest

    return this

]
