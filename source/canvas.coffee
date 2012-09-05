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

        @last_puck_position = { x: 0, y: 0 }
        @last_paddle_position = { x: 0, y: 0 }

        @ctx = @canvas.getContext '2d'

        @last_frame = 0

        @step = _.bind @step, @
        @render = _.bind @render, @

    render: ->

        # Don't draw unless game has updated
        return if @game.engine.frame is @last_frame

        # Clear the canvas
        #@ctx.clearRect 0, 0, @canvas.width, @canvas.height

        @ctx.fillStyle = '#fff'

        # Render the puck
        @renderPuck @game.puck

        # Render player paddle
        @renderPaddle @game.paddle

    renderPuck: (puck) ->
        @ctx.clearRect @last_puck_position.x, @last_puck_position.y, puck.width, puck.height
        @ctx.fillRect puck.x, puck.y, puck.width, puck.height
        @last_puck_position.x = puck.x
        @last_puck_position.y = puck.y

    renderPaddle: (paddle) ->
        @ctx.clearRect @last_paddle_position.x-2, @last_paddle_position.y-2, paddle.width+4, paddle.height+4
        @ctx.fillRect paddle.x, paddle.y, paddle.width, paddle.height
        @last_paddle_position.x = paddle.x
        @last_paddle_position.y = paddle.y

    start: ->
        @running = true
        requestAnimationFrame @step

    step: ->
        @render()
        if @running then requestAnimationFrame @step

    stop: ->
        @running = false
