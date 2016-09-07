$ = require 'jquery'
gsap = require 'gsap'
TweenLite = gsap.TweenLite
TimelineLite = gsap.TimelineLite

module.exports = [
  '$scope'
  '$window'
  'lodash'
  'SecurityService'
  'TokenService'
  (
    $scope
    $window
    _
    SecurityService
    TokenService
  ) ->

    $scope.scrollPosition = 0

    $scope.showLoginModal = false

    $scope.user = {}

    cache = {}

    $scope.animateFeatures = ($inviewInfo) ->
      options =
        scaleX: 1.0
        scaleY: 1.0
        ease: gsap.Bounce.easeOut

      element = $inviewInfo.element[0]
      SPEED = 0.5
      id = $(element).attr('id')
      if not cache[id]?
        line = new TimelineLite()
        images = $('.section-features img')
        line
          .to images.get(0), SPEED, options
          .to images.get(2), SPEED, options
          .to images.get(4), SPEED, options
          .to images.get(1), SPEED, options
          .to images.get(3), SPEED, options
          .to images.get(5), SPEED, options
      cache[id] = true

    $scope.carousel = [
      src: 'assets/images/yoga.png'
    ,
      src: 'assets/images/cat.png'
    ,
      src: 'assets/images/yoga.png'
    ,
      src: 'assets/images/cat.png'
    ,
      src: 'assets/images/yoga.png'
    ,
      src: 'assets/images/cat.png'
    ,
      src: 'assets/images/yoga.png'
    ,
      src: 'assets/images/cat.png'
    ]

    _.each $scope.carousel, (item, index) ->
      item.order = index
      item.title = index

    $scope.moveCarouselLeft = ->
      _.each $scope.carousel, (item) ->
        item.order = item.order - 1
        item.order = $scope.carousel.length - 1 if item.order < 0

    $scope.moveCarouselRight = ->
      _.each $scope.carousel, (item) ->
        item.order = (item.order + 1) % $scope.carousel.length

    $scope.getLeft = (item) ->
      dist = item.order - $scope.carousel.length / 2 + 1
      dist * 210 - 170

    $scope.getOpacity = (item) ->
      dist = Math.abs(item.order - $scope.carousel.length / 2 + 1)
      if dist >= 2
        Math.max 0, 0.8 - (dist - 2) * .8
      else
        1.0

    $scope.getScale = (item) ->
      dist = Math.abs(item.order - $scope.carousel.length / 2 + 1)
      scale = 1 - dist * .2
      "scale(#{scale}, #{scale})"

    $scope.getZIndex = (item) ->
      dist = Math.abs(item.order - $scope.carousel.length / 2 + 1)
      10 - dist

    $scope.orderItems = (item) ->

    $scope.login = ->
      SecurityService.login $scope.user
        .then (token) ->
          TokenService.setToken token
          $state.go 'pets'
        .catch (err) ->
          $scope.loginError = 'Invalid login information.  Please try again'

    $scope.isLoggedIn = ->
      TokenService.getToken()?

    return this
]
