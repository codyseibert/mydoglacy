module.exports = [
  'lodash'
  '$http'
  '$q'
  'API_PATH'
  (
    _
    $http
    $q
    API_PATH
  ) ->

    cleanup = (pet) ->
      p = _.cloneDeep pet
      p.carousel = p.carousel.map (item) ->
        image: item.image
      p

    post: (pet) ->
      $http.post "#{API_PATH}/pets", cleanup pet
        .then (response) ->
          response.data

    get: (id) ->
      $http.get "#{API_PATH}/pets/#{id}"
        .then (response) ->
          response.data

    put: (pet) ->
      $http.put "#{API_PATH}/pets/#{pet._id}", cleanup pet
        .then (response) ->
          response.data

    getMyPets: ->
      $http.get "#{API_PATH}/pets"
        .then (response) ->
          response.data

    cancel: (pet) ->
      $http.delete "#{API_PATH}/pets/#{pet._id}/subscription", cleanup pet
        .then (response) ->
          response.data
]
