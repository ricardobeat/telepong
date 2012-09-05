flour = require 'flour'

task 'build', ->

    bundle [
        'lib/utils.coffee'
        'lib/telepong.coffee'
    ], 'public/js/telepong.js'

task 'watch', ->

    flour.minifiers['.js'] = (file, cb) -> cb file.buffer

    invoke 'build'
    watch 'source/*.coffee', -> invoke 'build'