module.exports = [
  '$state'
  'lodash'
  (
    $state
    _
  ) ->

    restrict: 'E'

    templateUrl: 'edit_modal/edit_modal_directive.html'

    scope:
      current: '='

    link: (scope, elem, attr) ->

      scope.current = 0

      scope.sections = [
        title: 'Info'
        completed: false
        state: 'page.info'
      ,
        title: 'Details'
        completed: false
        state: 'page.details'
      ,
        title: 'Banner'
        completed: false
        state: 'page.banner'
      ,
        title: 'Biography'
        completed: false
        state: 'page.biography'
      ,
        title: 'Carousel'
        completed: false
        state: 'page.carousel'
      ,
        title: 'Review'
        completed: false
        state: 'page.review'
      ]

      scope.bubbleClicked = (section) ->
        $state.go section.state
        scope.current = scope.sections.indexOf section

      scope.save = ->
        scope.$broadcast "save #{scope.sections[scope.current].state}"

      scope.next = ->
        if scope.current is scope.sections.length
          console.log 'close modal'
        else
          scope.sections[scope.current].completed = true
          scope.current++
          $state.go scope.sections[scope.current].state

      scope.back = ->
        scope.current = Math.max 0, scope.current - 1
        $state.go scope.sections[scope.current].state

]
