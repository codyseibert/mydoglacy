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

    post: (pet) ->
      # TODO: Backend crashes because angular is inserting a $index into all the objects =(

      pet.carousel = pet.carousel.map (item) ->
        image: item.image

      $http.post "#{API_PATH}/pets", pet
        .then (response) ->
          response.data

    get: (id) ->
      $http.get "#{API_PATH}/pets/#{id}"
        .then (response) ->
          response.data

    getMyPets: ->
      $http.get "#{API_PATH}/pets"
        .then (response) ->
          response.data

]
