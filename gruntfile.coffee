module.exports = (grunt) ->

  grunt.initConfig
    pkg : grunt.file.readJSON('package.json')
    uglify :
      options :
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
    
      build : 
        src : 'src/<%= pkg.name %>.js',
        dest: 'build/<%= pkg.name %>.min.js'

    coffee: 
      concat:
        options: 
          bare: true
        files:
          'public/js/mini-term.js' : 'src/main/**/*.coffee'


      singles:
        options:
          bare : true
        expand: true,
        cwd: './src',
        src: ['**/*.coffee'],
        dest: './',
        ext: '.js'
        extDot : 'last'
      

    mochaTest:
      test:
        options:
          reporter: 'dot'
        src: ['test/**/*.js']

    nodemon:
      dev:
        script: 'server/server.js'
        options:
          watch : ['server']

    less:
      dev:
        files:
          "public/css/mini-term.css": "src/public/less/mini-term.less"
  

  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-nodemon')
  grunt.loadNpmTasks('grunt-contrib-less')
  
  grunt.registerTask('default', ['coffee:singles','less','coffee:concat','mochaTest'])
  grunt.registerTask('run', ['default','nodemon:dev'])




