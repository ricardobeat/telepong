# CSS renderer
# ---------------
class Telepong.CSS
    constructor: (@game) ->
        @running = false

        Telepong.screen.width = window.innerWidth
        Telepong.screen.height = window.innerHeight

        @last_puck_position = { x: 0, y: 0 }
        @last_paddle_position = { x: 0, y: 0 }

        @createStyles()

        @puck = @createElement 'puck'
        @paddle = @createElement 'paddle'

        @last_frame = 0

        @step = _.bind @step, @
        @render = _.bind @render, @

    createStyles: ->
        s = document.createElement 'style'
        s.type = 'text/css'
        s.innerHTML = """
            .entity {
                position: absolute;
                top: 0;
                left: 0;
                -webkit-transform: translate(0,0);
                -webkit-transition: -webkit-transform 0.05s;
            }
            .puck {
                background: #6ff;
                height: 20px;
                width: 20px;
                border-radius: 20px;
                box-shadow: 0 0 8px yellow;
            }
            .paddle {
                width: 200px;
                height: 20px;
                background: #99f;
                border: 1px solid #ccf;
                box-shadow:0 0 15px cyan;
            }
        """
        document.body.appendChild s

    createElement: (className) ->
        el = document.createElement 'div'
        el.className = 'entity '+className
        document.body.appendChild el
        return el

    render: ->

        # Don't draw unless game has updated
        return if @game.engine.frame is @last_frame

        @puck.style.webkitTransform = "translate(#{@game.puck.x}px, #{@game.puck.y}px)"
        @paddle.style.webkitTransform = "translate(#{@game.paddle.x}px, #{@game.paddle.y}px)"

    start: ->
        @running = true
        requestAnimationFrame @step

    step: ->
        @render()
        if @running then requestAnimationFrame @step

    stop: ->
        @running = false
