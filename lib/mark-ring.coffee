_ = require 'underscore-plus'
{Subscriber} = require "emissary"

module.exports =
class MarkRing
    Subscriber.includeInto(this)

    constructor: (editorView) ->
        {@editor, @gutter} = editorView

        @subscribeToCommand editorView, 'mark-ring:mark-cursor', @markCursor
        @subscribeToCommand editorView, 'mark-ring:recall-marks', @recallMarks
        @subscribeToCommand editorView, 'mark-ring:clear-marks', @clearMarks

        @addDecorationsForMarks

    markCursor: =>
        cursors = @editor.getCursors()
        for cursor in cursors
            mark = @getMarkUnderCursor(cursor)

            if not mark?
                @createMark(cursor.getBufferPosition())

    getMarkUnderCursor: (cursor) =>
        position = cursor.getBufferPosition()
        marks = @findMarks(containsBufferPosition: [position.row, position.column])
        [mark] =  (m for m in marks when m.getStartBufferPosition().isEqual(position))
        mark

    createMark: (position) ->
        mark = @displayBuffer().markBufferRange([[position.row, position.column],
                                                 [position.row, position.column + 1]],
                                                 @markAttributes(invalidate: 'never'))
        @subscribe mark, 'changed', ({isValid}) ->
            mark.destroy() unless isValid
        @editor.decorateMarker(mark, {type: 'highlight', class: 'mark'})
        mark

    clearMarks: =>
        mark.destroy() for mark in @findMarks()

    recallMarks: =>
        @editor.addCursorAtBufferPosition(mark.getStartBufferPosition()) for mark in @findMarks()

    addDecorationsForMarks: =>
        for mark in @marks when mark.isValid()
            @editor.decorateMarker(mark, {type: 'highlight', class: 'mark'})

        null

    findMarks: (attributes={}) ->
        @displayBuffer().findMarkers(@markAttributes(attributes))

    markAttributes: (attributes={}) ->
        _.extend(attributes, class: 'mark')

    displayBuffer: ->
        @editor.displayBuffer
