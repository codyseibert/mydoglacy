
module.exports = [
  '$scope'
  'HOLLA_BACK_PATH'
  'HOLLA_BACK_APP_ID'
  'TokenService'
  (
    $scope
    HOLLA_BACK_PATH
    HOLLA_BACK_APP_ID
    TokenService
  ) ->

    $scope.path = HOLLA_BACK_PATH
    $scope.token = TokenService.getToken()
    $scope.applicationId = HOLLA_BACK_APP_ID

    return this

]
