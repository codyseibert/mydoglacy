$ = require 'jquery'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  'lodash'
  'UserService'
  'SecurityService'
  'localStorageService'
  'PetService'
  'Upload'
  'API_PATH'
  '$http'
  'moment'
  (
    $scope
    $rootScope
    $interval
    _
    UserService
    SecurityService
    localStorageService
    PetService
    Upload
    API_PATH
    $http
    moment
  ) ->

    PetService.getMyPets()
      .then (pets) ->
        $scope.pets = pets

    $scope.isPublished = (pet) ->
      pet.activeUntil? and (moment().isBefore moment(pet.activeUntil))

    return this

]
