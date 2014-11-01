path = require 'path'

{$$, SelectListView} = require 'atom'

module.exports =
class MarkRingView extends SelectListView
  initialize: ->
    super
    @addClass('mark-ring-view overlay from-top')

  getFilterKey: ->
    'filterText'

  toggle: ->
    if @hasParent()
      @cancel()
    else
      @populateMarks()
      @attach()

  getFilterText: (mark) ->
    segments = []
    markRow = mark.marker.getStartPosition().row
    segments.push(markRow)
    if bufferPath = mark.buffer.getPath()
      segments.push(bufferPath)
    if lineText = @getLineText(mark)
      segments.push(lineText)
    segments.join(' ')

  getLineText: (mark) ->
    mark.buffer.lineForRow(mark.marker.getStartPosition().row)?.trim()

  populateMarks: ->
    marks = []
    attributes = class: 'mark'
    for buffer in atom.project.getBuffers()
      for marker in buffer.findMarkers(attributes)
        mark = {marker, buffer}
        mark.fitlerText = @getFilterText(mark)
        marks.push(mark)
    @setItems(marks)

  viewForItem: (mark) ->
    markRow = mark.marker.getStartPosition().row
    if filePath = mark.buffer.getPath()
      markLocation = "#{path.basename(filePath)}:#{markRow + 1}"
    else
      markLocation = "untitled:#{markRow + 1}"
    lineText = @getLineText(mark)

    $$ ->
      if lineText
        @li class: 'mark two-lines', =>
          @div markLocation, class: 'primary-line'
          @div lineText, class: 'secondary-line line-text'
      else
        @li class: 'mark', =>
          @div markLocation, class: 'primary-line'

  getEmptyMessage: (itemCount) ->
    if itemCount is 0
      'No marks found'
    else
      super

  confirmed: ({buffer, marker}) ->
    atom.workspace.open(buffer.getPath()).done (editor) ->
      editor.setSelectedBufferRange?(marker.getRange(), autoscroll: true)
    @cancel()

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()
