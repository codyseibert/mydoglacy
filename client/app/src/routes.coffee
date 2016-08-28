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

  return this
