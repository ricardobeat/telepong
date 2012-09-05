# Canvas renderer
# ---------------
class Telepong.Canvas
    constructor: (@game) ->
        @running = false

        @canvas = document.createElement 'canvas'
        @canvas.width = window.innerWidth
        @canvas.height = window.innerHeight
        document.body.appendChild @canvas

        Telepong.screen.width = @canvas.width
        Telepong.screen.height = @canvas.height

        @ctx = @canvas.getContext '2d'

        @last_frame = 0

        @step = _.bind @step, @
        @render = _.bind @render, @

    render: ->

        # Don't draw unless game has updated
        return if @game.engine.frame is @last_frame

        # Clear the canvas
        @ctx.clearRect 0, 0, @canvas.width, @canvas.height

        # Render the puck
        @renderPuck @game.puck

        # Render player paddles
        #@renderPaddle @game.paddle

    renderPuck: (puck) ->
        @ctx.fillStyle = '#fff'
        @ctx.fillRect puck.x, puck.y, puck.width, puck.height

    start: ->
        @running = true
        requestAnimationFrame @step

    step: ->
        @render()
        if @running then requestAnimationFrame @step

    stop: ->
        @running = false
