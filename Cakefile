flour = require 'flour'

task 'build', ->

    bundle [
        'source/utils.coffee'
        'source/telepong.coffee'
        'source/engine.coffee'
        'source/entities.coffee'
        'source/canvas.coffee'
    ], 'public/js/telepong.js'

task 'watch', ->

    flour.minifiers['.js'] = (file, cb) -> cb file.buffer

    invoke 'build'
    watch 'source/*.coffee', -> invoke 'build'