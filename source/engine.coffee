# Game engine
# -----------
# This is the logic loop. It's completely independent from the render loop.
class Telepong.Engine
    constructor: (@game) ->
        @fps = 30
        @step = 1/@fps

        @delta = 0
        @last_step = 0
        @logic_delta = 0
        @render_delta = 0

        @frame = 0

        _.bindAll @

    update: ->
        now = Date.now()
        @delta = Math.min 1, (now - @last_step) / 1000
        @logic_delta += @delta

        # step logic
        while @logic_delta > @step
            @logic_delta -= @step
            @game.update()

        @last_step = now
        @frame++
        if @running then setTimeout @update, 1000/@fps

    start: ->
        @running = true
        setTimeout @update, 1000/@fps 

    stop: ->
        @running = false
