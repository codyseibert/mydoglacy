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

    $scope.canCancel = (pet) ->
      not pet.isSubscriptionCanceled

    $scope.logout = ->
      TokenService.setToken null
      $state.go 'main'

    $scope.cancel = ($event, pet) ->
      $event.preventDefault()
      $event.stopPropagation()
      y = confirm 'are you sure you want to cancel this subscription'
      if y is true
        PetService.cancel(pet).then ->
          pet.isSubscriptionCanceled = true

    $scope.gotoView = (pet) ->
      $state.go 'view', id: pet._id

    return this

]
