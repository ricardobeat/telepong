
# Telepong
# ========
# This is the main object. It holds the constructor for all game elements,
# and emits events for communication between them.

Telepong = new EventEmitter2

_.extend Telepong,
    init: (options) ->
        @screen = {}

        @socket = options.socket
        @game = new Game options.render
        @game.run()

        @enableInput()

    enableInput: ->
        # TODO: detect touch/mouse/keyboard/etc
        @enableKeyboardInput()

    enableKeyboardInput: ->
        @keys = {}
        keymap =
            38: 'up'
            40: 'down'
            37: 'left'
            39: 'right'

        document.body.addEventListener 'keydown', (e) =>
            @keys[keymap[e.keyCode]] = true

        document.body.addEventListener 'keyup', (e) =>
            @keys[keymap[e.keyCode]] = false
            

# Game object
# -----------
# Holds game state and object instances.
class Game
    constructor: (RenderEngine) ->

        @renderer = new RenderEngine @

        # Initialize game objects.
        @puck = new Telepong.Puck @
        @paddle = new Telepong.Paddle @

        @engine = new Telepong.Engine @
        @setListeners()

        # Bind all methods to the instance permanently.
        _.bindAll @

    # Add event listeners.
    setListeners: ->
        Telepong.on 'getBall', @getBall

    run: ->
        @engine.start()
        @renderer.start()

    stop: ->
        @engine.stop()
        @renderer.stop()

    update: ->
        @puck.update()
        @paddle.update()

    passBall: (data) ->
        Telepong.emit 'passBall', data

    getBall: (data) ->
        @puck.mirror data

# Export globals
window.Telepong = Telepong
