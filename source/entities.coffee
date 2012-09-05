# Puck
# ----
# The game's puck.
class Telepong.Puck
    constructor: ->
        @width = 10
        @height = 10
        @x = Math.floor Telepong.screen.width / 2
        @y = 10
        @speedX = Math.ceil Math.random() * 5
        @speedY = 0
        @away = false

    step: ->
        @x += @speedX
        @y += @speedY

        if @y >= Telepong.screen.height
            @y = Telepong.screen.height
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

        if @x >= Telepong.screen.width or @x <= 0
            @speedX *= -1

    mirror: (data) ->
        @x = (1 - @x) * Telepong.screen.width
        @y = 10
        @speedX = data.speedX * -1
        @speedY = data.speedY * -1
