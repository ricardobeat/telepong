
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
        document.body.addEventListener 'keydown', (e) =>
            key_name = switch e.keyCode
                when 38 then 'up'
                when 40 then 'down'
                when 37 then 'left'
                when 39 then 'right'
            @emit 'keypress', key_name


# Game object
# -----------
# Holds game state and object instances.
class Game
    constructor: (RenderEngine) ->

        @renderer = new RenderEngine @

        # Initialize game objects.
        @puck = new Telepong.Puck
        @paddle = new Telepong.Paddle

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

    passBall: (data) ->
        Telepong.emit 'passBall', data

    getBall: (data) ->
        @puck.mirror data

# Export globals
window.Telepong = Telepong
