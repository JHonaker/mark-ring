{WorkspaceView} = require 'atom'
MarkRing = require '../lib/mark-ring'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MarkRing", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('mark-ring')

  describe "when the mark-ring:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.mark-ring')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'mark-ring:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.mark-ring')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'mark-ring:toggle'
        expect(atom.workspaceView.find('.mark-ring')).not.toExist()
