module.exports = [
  'lodash'
  'localStorageService'
  '$http'
  '$q'
  'API_PATH'
  (
    _
    localStorageService
    $http
    $q
    API_PATH
  ) ->

    user =
      email: null
      post: (user) ->
        $http.post "#{API_PATH}/users", user
          .then (response) ->
            response.data

]
