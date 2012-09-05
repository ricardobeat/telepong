
# Telepong
# ========
# This is the main object. It holds the constructor for all game elements,
# and emits events for communication between them.
Telepong = new EventEmitter

_.extend Telepong,
    renderer: null

# Game engine
# -----------
# This is the logic loop. It's completely independent from the render loop.
class Engine
    constructor: (@game) ->
        @fps = 30
        @step = 1/@fps

        @delta = 0
        @last_step = 0
        @logic_delta = 0
        @render_delta = 0

        @frame = 0

        @step = _.bind @step, @

    start: ->
        now = Date.now()
        @delta = Math.min 1, (now - @last_step) / 1000
        @logic_delta += @delta

        # step logic
        while @logic_delta > @step
            @logic_delta -= @step
            @game.update()

        @last_step = now

# Game object
# -----------
# Holds game state and object instances.
class Game
    constructor: (@renderer) ->

        # Initialize game objects.
        @puck = new Telepong.Puck

        @engine = new Engine @
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


# Puck
# ----
# The game's puck.
class Puck
    constructor: ->
        @width = 10
        @height = 10
        @x = Math.floor Telepong.stage.width / 2
        @y = 10
        @speedX = Math.ceil Math.random() * 5
        @speedY = 0
        @away = false

    step: ->
        @x += @speedX
        @y += @speedY

        if @y >= Telepong.stage.height
            @y = Telepong.stage.height
            @speedY *= -1

        if @y <= 10
            @speedY = 0
            @y = -20
            unless @away
                Telepong.game.passBall {
                    x: (@x / Telepong.stage.width).toFixed(2)
                    @speedX
                    @speedY
                }
                @away = true

        if @x >= Telepong.stage.width or @x <= 0
            @speedX *= -1

    mirror: (data) ->
        @x = (1 - @x) * Telepong.stage.width
        @y = 10
        @speedX = data.speedX * -1
        @speedY = data.speedY * -1

