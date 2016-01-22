fs = require 'fs'
glob = require 'glob'
path = require 'path'

module.exports = (grunt) ->
    grunt.initConfig

        watch:
            livereload:
                options:
                    livereload: true
                files: [
                    'dist/index.html'
                    'dist/slides/*/{,*/}*.{md,html,json}'
                    'dist/js/*.js'
                    'dist/css/*.css'
                    'dist/images/*/{,*/}*.{png,jpg,gif,svg}'
                    'dist/slides/**/_images/*.{png,jpg,gif,svg}'
                ]

            decks:
                files: [
                    'templates/_deck.html'
                    'templates/_section.html'
                    'slides/*/{,*/}*.{md,html,json}'
                ]
                tasks: [
                    'buildDecks'
                    'sync:slides'
                ]

            common_img:
                files: [
                    'images/**/*.{png,jpg,gif,svg}'
                ]
                tasks: [
                    'newer:imagemin:common'
                ]

            specific_img:
                files: [
                    'slides/**/_images/*.{png,jpg,gif,svg}'
                ]
                tasks: [
                    'newer:imagemin:specific'
                ]

            index:
                files: [
                    'templates/_index.html'
                    'slides/list.json'
                ]
                tasks: [
                    'buildIndex'
                    'sync:slides'
                ]

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: [
                    'jshint'
                    'sync:scripts'
                ]

            sass:
                files: ['scss/theme.scss', 'scss/print.scss']
                tasks: [
                    'sass'
                ]

        sass:
            theme:
                files:
                    'dist/css/theme.css': 'scss/theme.scss'
                    'dist/css/print.css': 'scss/print.scss'

        connect:
            livereload:
                options:
                    port: 9000
                # Change hostname to '0.0.0.0' to access
                # the server from outside.
                    hostname: 'localhost'
                    base: 'dist'
                    open: true
                    livereload: true

        coffeelint:
            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'ignore'

            all: ['Gruntfile.coffee']

        jshint:
            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:
            dist_model:
                files: [{
                    expand: true,
                    cwd: 'dist_model'
                    src: ['**']
                    dest: 'dist/'
                }]
            vendors:
                files: [{
                    expand: true
                    src: [
                        'bower_components/**'
                    ]
                    dest: 'dist/'
                }]
            slides:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                    ]
                    dest: 'dist/'
                }]

        clean:
            dist: ['dist/**']

        imagemin:
            common:
                files: [{
                    expand: true,
                    cwd: 'images/'
                    src: ['**/*.{png,jpg,gif,svg}']
                    dest: 'dist/images/'
                }]
            specific:
                files: [{
                    expand: true,
                    cwd: 'slides/'
                    src: ['**/*.{png,jpg,gif,svg}']
                    dest: 'dist/images/'
                }]

        sync:
            slides:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                    ]
                    dest: 'dist/'
                    pretend: false
                    updateAndDelete: true
                }]
            scripts:
                files: [{
                    expand: true
                    src: [
                        'js/**'
                    ]
                    dest: 'dist/'
                    pretend: false
                    updateAndDelete: true
                }]


    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'buildDecks',
        'Build desks from templates/_deck.html and slides/list.json.',
        ->
            chapters = grunt.file.readJSON 'slides/list.json'
            slugs = chapters.map (chapter) -> return (chapter.slug || null)

            for chapter in slugs when chapter isnt null
                do (chapter) ->
                    deckTemplate = grunt.file.read 'templates/_deck.html'
                    sectionTemplate = grunt.file.read 'templates/_section.html'

                    options = options || {}
                    options.cwd = 'slides/' + chapter + '/'
                    options.ignore = '*.json'
                    slides = glob.sync '[^_]*', options
                    slides = slides.map (f)->
                        elementPath = path.join options.cwd, f
                        fileStats = fs.lstatSync elementPath
                        if fileStats.isDirectory()
                            insideFiles = glob.sync f + '/[^_]*.{md,html}', options
                            return insideFiles
                        return f

                    html = grunt.template.process deckTemplate, data:
                        slides:
                            slides
                        section: (slide) ->
                            grunt.template.process sectionTemplate, data:
                                slide:
                                    chapter + '/' + slide
                    grunt.file.write 'dist/' + chapter + '.html', html

    grunt.registerTask 'buildIndex',
        'Build index.html from slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            chapters = grunt.file.readJSON 'slides/list.json'
            html = grunt.template.process indexTemplate, data:
                chapters:
                    chapters
            grunt.file.write 'dist/index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'serve',
        'Build presentations and start watch process (living document).', [
            'build'
            'live'
        ]

    grunt.registerTask 'live',
        'Start watch process (living document) for already built files in dist folder.', [
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'build',
        'Build presentations.', [
            'reset'
            'buildDecks'
            'buildIndex'
            'sass'
            'newer:copy:vendors'
            'sync:slides'
            'sync:scripts'
            'newer:imagemin'
        ]

    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'build'
    ]

    grunt.registerTask 'reset',
        'Reset the dist with the default content', [
            'clean:dist'
            'copy:dist_model'
        ]
