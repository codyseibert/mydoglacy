module.exports = [
  '$rootScope'
  (
    $rootScope
  ) ->

    restrict: 'E'

    scope:
      save: '&'
      editing: '='

    link: (scope, elem, attr) ->

      scope.edit = ->
        scope.editing = !scope.editing

      scope.preSave = ->
        scope.editing = false
        scope.save()

    templateUrl: 'page/btnedit/btnedit.html'

]
