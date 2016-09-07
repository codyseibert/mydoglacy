shuffle = require 'shuffle-array'
$ = require 'jquery'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  '$timeout'
  '$stateParams'
  'lodash'
  'PageService'
  'UserService'
  'SecurityService'
  'localStorageService'
  'PetService'
  'TokenService'
  'Upload'
  'API_PATH'
  '$http'
  (
    $scope
    $rootScope
    $interval
    $timeout
    $stateParams
    _
    PageService
    UserService
    SecurityService
    localStorageService
    PetService
    TokenService
    Upload
    API_PATH
    $http
  ) ->


    $scope.petId = $stateParams.id
    if $scope.petId?
      $scope.isViewMode = true

      PetService.get $scope.petId
        .then (pet) ->
          $scope.page = pet

          $scope.page.layouts =
            main: 0

          $timeout ->
            $scope.$apply()

          # TODO: If the pet is no longer active, redirect user to an inactive pet page

          # TODO: If the user owns the pet, also allow edit mode
    else
      $scope.isViewMode = false
      $scope.showModal = true
      $scope.showRegisterModal = false
      $scope.isEditMode = false

      $scope.$watch ->
        PageService
      , ->
        $scope.page = PageService
        localStorageService.set 'page', PageService
      , true

      $scope.page = PageService
      delete $scope.page._id if $scope.page._id?

      $scope.page.layouts =
        main: 0

    $scope.currentSection = 0
    $scope.isEditMode = false
    $scope.currentStep = 0

    $scope.editing =
      name: false

    $scope.editItem = (key) ->
      return if not $scope.isEditMode
      $scope.editing[key] = true

    $scope.$on 'closeEditModal', ->
      $scope.showEditModal = false

    $scope.hideModal = ->
      $scope.showModal = false
      $scope.currentStep = 1

    $scope.publish = ->
      if TokenService.getToken()?
        # we are already logged in
        PetService.post $scope.page
          .then (pet) ->
            $scope.page._id = pet._id
            $scope.openStripe()
      else
        $scope.showRegisterModal = true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.isEditMode = not $scope.isEditMode
      $scope.currentStep = 2

    $scope.openStripe = ->
      $rootScope.STRIPE.open(
        name: "Publish #{$scope.page.name}'s Page",
        description: "Subscribe to publish #{$scope.page.name}'s page"
        zipCode: true
        email: UserService.getUser().email
        amount: 999
        panelLabel: "{{amount}} per year"
      )

    $rootScope.$on 'charge.started', ->
      $scope.showChargingModal = true

    $rootScope.$on 'charge.success', (evt, petId) ->
      $scope.showChargingModal = false
      $scope.showSuccessModal = true
      $scope.petId = petId

    $scope.register = ->
      # Create a new account
      UserService.post $scope.user
        .then ->
          # Login to get the JWT
          SecurityService.login $scope.user
            .then ->
              # Post the pet
              PetService.post $scope.page
                .then (pet) ->
                  $scope.page._id = pet._id
                  $scope.showRegisterModal = false
                  $scope.openStripe()
                .catch (err) ->
              # There was a problem with creating the pet
        .catch (err) ->
          # If the account already exists, request that the user logs in

    $scope.cardClicked = (card) ->

    $scope.save = ->

    $scope.onSlideUpload = (image) ->
      $scope.page.carousel.push
        image: image
        title: 'Testing'
        description: 'testing'
      $scope.slide = $scope.page.carousel[$scope.page.carousel.length - 1]

    $scope.delete = (slide) ->
      return if not confirm 'Are you sure you want to delete this image?'
      $scope.page.carousel.splice $scope.page.carousel.indexOf(slide), 1
      gotoNextSlide()

    $scope.upload = (file, obj, key) ->
      obj[key] = 'assets/images/uploading.gif'
      Upload.upload(
        url: "#{API_PATH}/images"
        data:
          file: file
      )
        .then (resp) ->
          obj[key] = resp.data
        , (resp) ->
          console.log 'Error', resp
        , (evt) ->
          # scope.percent = parseInt(100.0 * evt.loaded / evt.total)

    return this

]
