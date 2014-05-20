module.exports = (grunt) ->

  grunt.initConfig
    pkg : grunt.file.readJSON('package.json')
    uglify :
      options :
        banner: '/*! <%= pkg.name %> <%= pkg.version %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
    
      build : 
        src : 'dist/<%= pkg.name %>.js',
        dest: 'dist/<%= pkg.name %>.min.js'

    coffee: 
      concat:
        options: 
          bare: true
        files:
          'dist/<%= pkg.name %>.js' : 'src/main/**/*.coffee'

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
        files: [
          { expand: true,cwd:'src/examples',src: ['**/*.less'], dest: 'examples/' , ext:'.css'}
          { src: ['src/less/mini-term.less'], dest: 'dist/mini-term.css'}
        ]  
  
    copy:
      main:
        files: [
          { expand: true,cwd:'src/test/site/html/',src: ['**'], dest: 'test/site/html/' }
        ]  

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-nodemon')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-copy')
  
  grunt.registerTask('default', ['coffee:singles','less','coffee:concat','uglify','copy','mochaTest'])
  grunt.registerTask('run', ['default','nodemon:dev'])




