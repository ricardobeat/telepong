# Base Entity
# -----------

class Entity
    constructor: ->
        @x = 0
        @y = 0
        @speedX = 0
        @speedY = 0

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
        @speedY = 10
        @away = false

        @boundaries = 
            top    : 0
            left   : 0
            bottom : Telepong.screen.height - @height
            right  : Telepong.screen.width - @width

    update: ->
        @x += @speedX
        @y += @speedY

        if @y >= @boundaries.bottom
            @y = @boundaries.bottom
            @speedY *= -1

        if @y <= 0
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
