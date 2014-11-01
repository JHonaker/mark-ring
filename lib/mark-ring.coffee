_ = require 'underscore-plus'
{Subscriber} = require "emissary"

module.exports =
class MarkRing
    Subscriber.includeInto(this)

    constructor: (editorView) ->
        {@editor, @gutter} = editorView
        console.log @editor

        @subscribeToCommand editorView, 'mark-ring:toggle-mark', @toggleMark
        @subscribeToCommand editorView, 'mark-ring:recall-marks', @recallMarks
        @subscribeToCommand editorView, 'mark-ring:clear-marks', @clearMarks

        @addDecorationsForMarks

    toggleMark: =>
        console.log @editor
        cursors = @editor.getCursors()
        for cursor in cursors
            position = cursor.getBufferPosition()
            mark = @findMarks(startBufferPosition: position)

            if mark?
                @createMark(position)
            else
                mark.destroy()



    createMark: (position) ->
        mark = @displayBuffer().markBufferPosition(position, @markAttributes(invalidate: 'never'))
        @subscribe mark, 'changed', ({isValid}) ->
            mark.destroy() unless isValid
        @editor.decorateMarker(mark, {type: 'gutter', class: 'mark'})
        mark

    clearMarks: =>
        mark.destroy() for mark in @findMarks()

    recallMarks: =>
        @editor.addCursorAtBufferPosition(mark.getStartBufferPosition()) for mark in @findMarks()
        @clearMarks()

    addDecorationsForMarks: =>
        for mark in @findMarks() when mark.isValid()
            @editor.decorateMarker(mark, {type: 'gutter', class: 'mark'})

        null

    findMarks: (attributes={}) ->
        @displayBuffer().findMarkers(@markAttributes(attributes))

    markAttributes: (attributes={}) ->
        _.extend(attributes, class: 'mark')

    displayBuffer: ->
        @editor.displayBuffer
