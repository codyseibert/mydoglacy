module.exports = (
  $stateProvider
  $urlRouterProvider
  $locationProvider
) ->
  $urlRouterProvider.otherwise '/'

  $locationProvider.html5Mode enabled: true, requireBase: false
  $locationProvider.hashPrefix '!'

  $stateProvider
    .state 'main',
      url: '/'
      views:
        'main':
          controller: 'MainCtrl'
          templateUrl: 'main/main.html'

    .state 'page',
      url: '/new'
      views:
        'main':
          controller: 'PageCtrl'
          templateUrl: 'page/page.html'

    .state 'pets',
      url: '/pets'
      views:
        'main':
          controller: 'PetsCtrl'
          templateUrl: 'pets/pets.html'

    .state 'view',
      url: '/:id'
      views:
        'main':
          controller: 'PageCtrl'
          templateUrl: 'page/page.html'

  return this
