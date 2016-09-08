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

    get: (userId) ->
      $http.get "#{API_PATH}/users/#{userId}"
        .then (response) ->
          response.data

    post: (user) ->
      $http.post "#{API_PATH}/users", user
        .then (response) ->
          response.data

]
