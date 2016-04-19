module.exports = (
  $stateProvider,
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'main',
      url: '/'
      views:
        'main':
          controller: 'MainCtrl'
          templateUrl: 'main/main.html'

    .state 'page',
      url: '/page'
      views:
        'main':
          controller: 'PageCtrl'
          templateUrl: 'page/page.html'

    .state 'page.info',
      url: '/edit/info'
      views:
        'section':
          controller: 'InfoSectionCtrl'
          templateUrl: 'sections/info_section.html'

    .state 'page.details',
      url: '/edit/details'
      views:
        'section':
          controller: 'DetailsSectionCtrl'
          templateUrl: 'sections/details_section.html'

    .state 'page.banner',
      url: '/edit/banner'
      views:
        'section':
          controller: 'BannerSectionCtrl'
          templateUrl: 'sections/banner_section.html'

    .state 'page.biography',
      url: '/edit/biography'
      views:
        'section':
          controller: 'BiographySectionCtrl'
          templateUrl: 'sections/biography_section.html'

    .state 'page.carousel',
      url: '/edit/carousel'
      views:
        'section':
          controller: 'CarouselSectionCtrl'
          templateUrl: 'sections/carousel_section.html'

    .state 'page.review',
      url: '/edit/review'
      views:
        'section':
          controller: 'ReviewSectionCtrl'
          templateUrl: 'sections/review_section.html'

  return this
