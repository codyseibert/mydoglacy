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
      token = TokenService.getToken()
      return null if not token?
      decode = jwt.decode token
      return null if not decode?
      decode

    get: (userId) ->
      $http.get "#{API_PATH}/users/#{userId}"
        .then (response) ->
          response.data

    post: (user) ->
      $http.post "#{API_PATH}/users", user
        .then (response) ->
          response.data

    verify: (body) ->
      $http.post "#{API_PATH}/accounts/verify", body
        .then (response) ->
          response.data

]
