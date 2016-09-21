module.exports = [
  '$scope'
  '$state'
  '$location'
  'lodash'
  'PasswordService'
  'SecurityService'
  (
    $scope
    $state
    $location
    _
    PasswordService
    SecurityService
  ) ->

    $scope.user = {}

    uuid = $location.search().resetUuid
    userId = $location.search().userId
    if not uuid? or not userId?
      console.log 'TODO: error, uuid or userId was not set'
    else
      $scope.user.resetUuid = uuid
      $scope.user.userId = userId

    $scope.reset = ->
      if $scope.user.password isnt $scope.user.repeat
        console.log 'TODO: passwords do not match, display a warning'
      else
        PasswordService.reset _.pick $scope.user, ['userId', 'resetUuid', 'password']
          .catch ->
            console.log 'TODO: the reset link was expired, display a message'
          .then (user) ->
            SecurityService.login user
          .then ->
            console.log 'TODO: Display a message, timeout 1 second and redirect'
            $state.go 'pets'

    return this

]
