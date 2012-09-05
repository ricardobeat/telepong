class Telepong.Game
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
