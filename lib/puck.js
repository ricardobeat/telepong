;(function(exports){

    function Puck(){
        this.stage = Telepong.game.stage
        this.width = 10
        this.height = 10
        this.x = Math.floor(this.stage.width / 2)
        this.y = 10
        this.speedX = Math.ceil(Math.random() * 5)
        this.speedY = 8
        this.away = false
    }

    Puck.prototype.step = function(){

        this.x += this.speedX
        this.y += this.speedY

        if (this.y >= this.stage.height){
            this.y = this.stage.height
            this.speedY *= -1
        }

        if (this.y <= 10){
            if (!this.away){
                Telepong.game.passBall({
                    x: (this.x / this.stage.width).toFixed(2),
                    speedX: this.speedX,
                    speedY: this.speedY
                })
                this.away = true
            }
            this.speedY = 0
            this.y = -20
        }

        if (this.x >= this.stage.width || this.x <= 0){
            this.speedX *= -1
        }
    }

    Puck.prototype.mirror = function(data){
        this.x = (1 - data.x) * this.stage.width
        this.y = 10
        this.speedX = data.speedX * -1
        this.speedY = data.speedY * -1
        this.away = false
    }

    exports.Puck = Puck

})(window.Telepong)
