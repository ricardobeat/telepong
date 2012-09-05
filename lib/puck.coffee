class Telepong.Puck
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
