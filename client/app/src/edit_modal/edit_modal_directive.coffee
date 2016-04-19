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
      show: '='

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
        title: 'Memories'
        completed: false
        state: 'page.memories'
      ,
        title: 'Banner Images'
        completed: false
        state: 'page.banner'
      ,
        title: 'Carousel Images'
        completed: false
        state: 'page.carousel'
      ,
        title: 'Review'
        completed: false
        state: 'page.review'
      ]

      scope.save = ->

      scope.next = ->
        if scope.current is scope.sections.length
          console.log 'close modal'
        else
          scope.sections[scope.current].completed = true
          scope.current++
          $state.go scope.sections[scope.current].state
          console.log scope.current

      scope.back = ->
        scope.current = Math.max 0, scope.current - 1

]
