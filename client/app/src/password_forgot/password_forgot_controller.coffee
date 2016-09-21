module.exports = [
  '$scope'
  '$state'
  '$location'
  'lodash'
  'PasswordService'
  (
    $scope
    $state
    $location
    _
    PasswordService
  ) ->

    $scope.user = {}
    $scope.showRequestForm = true

    $scope.requestNewPassword = ->
      if not $scope.user.email?
        console.log 'email must be set'
      else
        PasswordService.forgot $scope.user
          .then ->
            $scope.showRequestForm = false

    return this

]
