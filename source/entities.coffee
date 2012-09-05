# Base Entity
# -----------

class Entity
    constructor: (@game) ->
        @x = 0
        @y = 0
        @speedX = 0
        @speedY = 0

    setBoundaries: ->
        @boundaries = 
            top    : 0
            left   : 0
            bottom : Telepong.screen.height - @height
            right  : Telepong.screen.width - @width

    update: ->

# Puck
# ----
# The game's puck.
class Telepong.Puck extends Entity
    constructor: ->
        super
        @width = 10
        @height = 10
        @x = Math.floor Telepong.screen.width / 2
        @speedX = Math.ceil Math.random() * 5
        @speedY = 15
        @away = false
        @setBoundaries()

    update: ->
        @x += @speedX
        @y += @speedY

        bottom = @y + @height

        if @y >= @boundaries.bottom
            @y = @boundaries.bottom
            @speedY *= -1

        else if @y >= @game.paddle.y and @game.paddle.x < @x < @game.paddle.x + @game.paddle.width
            @speedY *= -1
            @y = @game.paddle.y - @height - 1
            paddleCenter = @game.paddle.x + @game.paddle.width / 2
            @speedX = Math.floor ((@x - paddleCenter) / @game.paddle.width) * 15

        else if @y <= 0
            @speedY *= -1
            return

            @speedY = 0
            @y = -20
            unless @away
                Telepong.game.passBall {
                    x: (@x / Telepong.screen.width).toFixed(2)
                    @speedX
                    @speedY
                }
                @away = true

        if @x >= @boundaries.right or @x <= @boundaries.left
            @speedX *= -1

    mirror: (data) ->
        @x = (1 - @x) * Telepong.screen.width
        @y = 10
        @speedX = data.speedX * -1
        @speedY = data.speedY * -1

# Paddle
# ------
class Telepong.Paddle extends Entity
    constructor: ->
        super
        @width = Math.floor Telepong.screen.width / 4
        @width = Math.max 100, Math.min 200, @width
        @height = 20
        @x = Telepong.screen.width/2 - @width/2
        @y = Telepong.screen.height - 40
        @maxSpeed = Math.floor Telepong.screen.width / 50
        @setBoundaries()

    update: ->
        @x += @speedX
        switch true
            when Telepong.keys.left
                @speedX = -@maxSpeed
                #@speedX = Math.min -3, Math.max -12, @speedX *= 1.1
            when Telepong.keys.right
                @speedX = @maxSpeed
                #@speedX = Math.max 3, Math.min 12, @speedX *= 1.1
            else @speedX = 0

        if @x >= @boundaries.right
            @x = @boundaries.right - 1

        else if @x <= @boundaries.left
            @x = @boundaries.left + 1
