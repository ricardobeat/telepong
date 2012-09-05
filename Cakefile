flour = require 'flour'

task 'build', ->

    bundle [
        'lib/utils.coffee'
        'lib/telepong.coffee'
    ], 'dist/telepong.js'

task 'watch', ->

    flour.minifiers['.js'] = (file, cb) -> cb file.buffer

    invoke 'build'
    watch 'lib/*.js', -> invoke 'build'