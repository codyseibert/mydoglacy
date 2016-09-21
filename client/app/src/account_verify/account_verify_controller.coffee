module.exports = [
  '$scope'
  '$state'
  '$location'
  'lodash'
  'UserService'
  (
    $scope
    $state
    $location
    _
    UserService
  ) ->

    code = $location.search().code

    if not code?
      console.log 'error: the verification code was not set'
    else
      UserService.verify verify: code
        .then ->
          $state.go 'pets'

    return this

]
