MarkRingView = require './mark-ring-view'

module.exports =
  markRingView: null

  activate: (state) ->
    @markRingView = new MarkRingView(state.markRingViewState)

  deactivate: ->
    @markRingView.destroy()

  serialize: ->
    markRingViewState: @markRingView.serialize()
