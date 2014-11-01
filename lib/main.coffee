MarkRing = null
MarkRingView = null

module.exports =
    activate: ->
        markRingView = null

        atom.workspaceView.command 'mark-ring:view-all', ->
            unless bookmarksList?
                MarkRingView ?= require './mark-ring-view'
                markRingView = new MarkRingView()
            markRingView.toggle()

        atom.workspaceView.eachEditorView (editorView) ->
            if editorView.attached and editorView.getPane?
                MarkRing ?= require './mark-ring'
                new MarkRing(editorView)
