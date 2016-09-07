$ = require 'jquery'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  'lodash'
  'PageService'
  'UserService'
  'SecurityService'
  'localStorageService'
  'PetService'
  'Upload'
  'API_PATH'
  '$http'
  (
    $scope
    $rootScope
    $interval
    _
    PageService
    UserService
    SecurityService
    localStorageService
    PetService
    Upload
    API_PATH
    $http
  ) ->

    PetService.getMyPets()
      .then (pets) ->
        $scope.pets = pets

    return this

]
