_ = require 'lodash'
_.defaults = require 'merge-defaults'
fs = require 'fs'
util = require 'util'
gulp = require 'gulp'
bower = require 'bower'
sass = require 'gulp-sass'
less = require 'gulp-less'
concat = require 'gulp-concat'
merge = require 'streamqueue'
minify = require 'gulp-minify-css'
rename = require 'gulp-rename'
browserify = require 'browserify'
streamify = require 'gulp-streamify'
uglify = require 'gulp-uglify'
source = require 'vinyl-source-stream'
rework = require 'gulp-rework'
reworkNPM = require 'rework-npm'
cleanCSS = require 'gulp-clean-css'
templateCache = require 'gulp-angular-templatecache'
whitespace = require 'gulp-css-whitespace'
del = require 'del'
glob = require 'glob'

gulp.task 'default', ['css', 'template', 'coffee']

gulp.task 'config', ->
  cfg = glob
    .sync './config/*.coffee'
    .concat glob.sync "./config/env/#{process.env.NODE_ENV}.coffee"
    .reduce (cfg, file) ->
      cfg = _.defaults require(file), cfg
  params = _.pick process.env, 'AUTHURL', 'CLIENT_ID', 'SCOPE'
  fs.writeFileSync 'www/js/config.json', util.inspect
    AUTHURL: cfg.oauth2.url.authorize
    CLIENT_ID: cfg.oauth2.client.id
    SCOPE: cfg.oauth2.scope

gulp.task 'css', ->
  [lessAll, scssAll, cssAll] = [
    gulp.src ['./scss/bootstrap.less']
      .pipe less()
      .pipe concat 'less-files.less'
    gulp.src ['./scss/ionic.app.scss']
      .pipe sass()
      .pipe concat 'scss-files.scss'
    gulp.src 'www/css/index.css'
      .pipe whitespace()
      .pipe rework reworkNPM shim: 'angular-toastr': 'dist/angular-toastr.css'
      .pipe concat 'css-files.css'
  ]
  merge objectMode: true, lessAll, cssAll, scssAll
    .pipe concat 'ionic.app.css'
    .pipe gulp.dest 'www/css/'
    .pipe cleanCSS()
    .pipe rename extname: '.min.css'
    .pipe gulp.dest 'www/css/'

gulp.task 'coffee', ['config'], ->
  browserify(entries: ['./www/js/index.coffee'])
    .transform 'coffeeify'
    .transform 'debowerify'
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './www/js/'
    .pipe streamify uglify()
    .pipe rename extname: '.min.js'
    .pipe gulp.dest './www/js/'

gulp.task 'template', ->
  gulp.src('./www/templates/**/*.html')
    .pipe(templateCache(root: 'templates', standalone: true))
    .pipe(gulp.dest('./www/js/'))

gulp.task 'clean', ->
  del [
    'www/css/ionic.app.css'
    'www/css/ionic.app.min.css'
    'node_modules'
    'www/lib'
    'www/js/*.js'
  ]
