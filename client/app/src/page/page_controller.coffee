shuffle = require 'shuffle-array'
$ = require 'jquery'

module.exports = [
  '$scope'
  '$rootScope'
  '$interval'
  '$timeout'
  '$state'
  '$stateParams'
  'lodash'
  'UserService'
  'SecurityService'
  'localStorageService'
  'PetService'
  'TokenService'
  'Upload'
  'API_PATH'
  '$http'
  'moment'
  (
    $scope
    $rootScope
    $interval
    $timeout
    $state
    $stateParams
    _
    UserService
    SecurityService
    localStorageService
    PetService
    TokenService
    Upload
    API_PATH
    $http
    moment
  ) ->

    userOwnsPet = (pet) ->
      user = UserService.getUser()
      return false if not user?
      pet.userId is user._id

    isLoggedIn = ->
      TokenService.getToken()?

    createPet = ->
      PetService.post $scope.page
        .then (pet) ->
          $scope.page.userId = pet.userId
          $scope.page._id = pet._id
          pet

    setupUpdateWatcher = ->
      $scope.$watch ->
        $scope.page
      , ->
        if $scope.page?
          localStorageService.set 'page', $scope.page
          if $scope.page._id? and $scope.page.userId?
            PetService.put $scope.page
              .then ->
      , true

    $scope.isViewOnly = true
    $scope.isEditMode = false
    $scope.currentSection = 0
    $scope.currentStep = 0
    $scope.editing = {}

    if $stateParams.id?
      PetService.get $stateParams.id
        .then (pet) ->
          $scope.page = pet
          if userOwnsPet pet
            $scope.isViewOnly = false
            setupUpdateWatcher()
        .catch (err) ->
          # we must have an invalid pet id
          # TODO: Redirect to a PET NOT FOUND page
          $state.go 'main'
    else
      $scope.isViewOnly = false
      # We reached this controller via /#/new
      p = localStorageService.get('page')
      if p?
        $scope.page = p
      else
        $scope.page =
          name: 'Lacy'
          gender: 'Male'
          breed: 'Golden Retriever'
          layout: '0'
          headline: '5/23/1991 - 3/2/2016'
          banner: 'assets/images/dog-main-min.png'
          memory: 'Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet .'
          biography: 'Pellentesque habitant molibero sit amet quam egestas semper. Aenean ultricies mi vitae est. Aenean ultricies mi vitae est.'
          titleA: "Lacy Look'n Legit"
          snippitA: "Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit"
          story: """
            <h1>Lacy's Story</h1>
            <p>Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. </p>
            <p>Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. </p>
          """
          titleB: "What a Babe"
          snippitB: "Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam"
          imageA: 'assets/images/dog1.png'
          imageB: 'assets/images/dog2.png'
          imageC: 'assets/images/dog3.png'
          imageD: 'assets/images/dog4.png'
          imageE: 'assets/images/dog5.png'
          imageF: 'assets/images/dog5.png'
          imageG: 'assets/images/dog5.png'
          imageH: 'assets/images/dog5.png'
          imageI: 'assets/images/dog5.png'
          imageJ: 'assets/images/dog5.png'
          carousel: [
            image: 'assets/images/dog-main-min.png'
          ,
            image: 'assets/images/dog5.png'
          ,
            image: 'assets/images/dog1.png'
          ,
            image: 'assets/images/dog2.png'
          ,
            image: 'assets/images/dog3.png'
          ,
            image: 'assets/images/dog-main-min.png'
          ,
            image: 'assets/images/dog4.png'
          ,
            image: 'assets/images/dog5.png'
          ,
            image: 'assets/images/dog2.png'
          ,
            image: 'assets/images/dog3.png'
          ,
            image: 'assets/images/dog3.png'
          ,
            image: 'assets/images/dog3.png'
          ]
        $scope.showModal = true

      setupUpdateWatcher()

      if isLoggedIn() and not $scope.page.userId?
        createPet()
      else if $scope.page.userId? and $scope.page.activeUntil?
        # TODO: I don't think this branch should every be needed, but just in case?
        localStorageService.remove 'page'
        $state.go 'view', id: $scope.page._id

    $scope.isLoggedIn = ->
      TokenService.getToken()?

    $scope.isPublished = ->
      $scope.page.activeUntil? and (moment().isBefore moment($scope.page.activeUntil))

    $scope.editItem = (key) ->
      return if not $scope.isEditMode
      $scope.editing[key] = true

    $scope.hideModal = ->
      $scope.showModal = false
      $scope.currentStep = 1

    $scope.publish = ->
      if TokenService.getToken()?
        $scope.openStripe()
      else
        $scope.showRegisterModal = true

    $scope.edit = ->
      $scope.currentSection = 0
      $scope.isEditMode = not $scope.isEditMode
      $scope.currentStep = 2

    $scope.openStripe = ->
      strip = StripeCheckout.configure(
        key: 'pk_test_VSOl2a32ywHvrzNjzQfxTFBD'
        locale: 'auto'
        token: (token) ->
          # $rootScope.$emit 'charge.started'
          $scope.showChargingModal = true
          $http.post "#{API_PATH}/charge", {stripeToken: token, page: $scope.page, email: UserService.getUser().email}
            .then (res) ->
              petId = res.data._id
              $scope.showChargingModal = false
              $scope.showSuccessModal = true
              $scope.petId = petId
              $scope.activeUntil = res.data.activeUntil
              localStorageService.remove 'page'
            .catch (err) ->
      )

      strip.open(
        name: "Publish #{$scope.page.name}'s Page",
        description: "Subscribe to publish #{$scope.page.name}'s page"
        zipCode: true
        email: UserService.getUser().email
        amount: 999
        panelLabel: "{{amount}} per year"
      )

    $scope.closeRegisterModal = ->
      return if $scope.showRegisterModal is false
      $scope.showRegisterModal = false

    $scope.register = ->
      UserService.post $scope.user
        .then ->
          SecurityService.login $scope.user
            .then ->
              createPet()
                .then ->
                  $scope.showRegisterModal = false
                  $scope.openStripe()
                .catch (err) ->
                  console.log err
            .catch (err) ->
              console.log err
        .catch (err) ->
          console.log err

    # $scope.onSlideUpload = (image) ->
    #   $scope.page.carousel.push
    #     image: image
    #     title: 'Testing'
    #     description: 'testing'
    #   $scope.slide = $scope.page.carousel[$scope.page.carousel.length - 1]

    # $scope.delete = (slide) ->
    #   return if not confirm 'Are you sure you want to delete this image?'
    #   $scope.page.carousel.splice $scope.page.carousel.indexOf(slide), 1
    #   gotoNextSlide()

    $scope.deleteCard = (card) ->
      index = _.findIndex $scope.page.carousel, (entry) ->
        entry.image is card.image
      $scope.page.carousel.splice index, 1

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
