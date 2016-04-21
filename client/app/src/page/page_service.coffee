module.exports = [
  'lodash'
  'localStorageService'
  (
    _
    localStorageService
  ) ->

    page = localStorageService.get 'page'

    page ?=
      pet:
        name: null
        gender: null
        breed: null
        date_of_birth: null
        date_of_rest: null
      banner: ''
      biography: ''
      carousel: []
      options:
        facebook:
          share: false
          comments: false
        twitter:
          share: false

]
