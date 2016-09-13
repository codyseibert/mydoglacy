$ = require 'jquery'

module.exports = [
  '$scope'
  '$state'
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
  'TokenService'
  (
    $scope
    $state
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
    TokenService
  ) ->

    PetService.getMyPets()
      .then (pets) ->
        $scope.pets = pets

    $scope.isPublished = (pet) ->
      pet.activeUntil? and (moment().isBefore moment(pet.activeUntil))

    $scope.logout = ->
      TokenService.setToken null
      $state.go 'main'

    return this

]
