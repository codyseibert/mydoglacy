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

  return this
