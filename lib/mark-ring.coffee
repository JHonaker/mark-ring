MarkRingView = require './mark-ring-view'

addMark = (position) ->

clearMark = (position) ->

moveToMark = (direction) ->

moveToNextMark = ->

moveToPreviousMark = ->

removeAllMarks = ->

recallMarks = ->

module.exports =
  markRingView: null

  activate: (state) ->
    @markRingView = new MarkRingView(state.markRingViewState)

  deactivate: ->
    @markRingView.destroy()

  serialize: ->
    markRingViewState: @markRingView.serialize()
