class canvasRenderer
    constructor: (@game) ->
        @running = false

        @step = _.bind @step, @

    render: ->

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
        requestAnimationFrame =>
            @render()

    step: ->
        @render()
        if @running then requestAnimationFrame @step

    stop: ->
        @running = false
