
# Telepong
# ========
# This is the main object. It holds the constructor for all game elements,
# and emits events for communication between them.
Telepong = new EventEmitter

# Game object
# -----------
# Holds game state and object instances.
class Game
    constructor: (@stage, @socket) ->

        @ctx = @stage.getContext '2d'
        @puck = new Telepong.Puck
        @setBindings()
        @setListeners()

    setBindings: ->
        @step = @step.bind @

    setListeners: ->
        @socket.on 'getBall', (data) =>
            @getBall data

    run: ->
        @running = true
        @step()

    step: ->
        @puck.step()
        @render()
        requestAnimationFrame @step

    stop: ->
        @running = false

    render: ->
        @ctx.clearRect 0, 0, @stage.width, @stage.height

    passBall: (data) ->
        @socket.emit 'passBall', data

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

