jwt = require 'jsonwebtoken'

module.exports = [
  'lodash'
  'localStorageService'
  '$http'
  '$q'
  'TokenService'
  'API_PATH'
  (
    _
    localStorageService
    $http
    $q
    TokenService
    API_PATH
  ) ->

    getUser: ->
      jwt.decode(TokenService.getToken())._doc

    post: (user) ->
      $http.post "#{API_PATH}/users", user
        .then (response) ->
          response.data

]
