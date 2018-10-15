gulp = require 'gulp'
pug = require 'gulp-pug'
stylus = require 'gulp-stylus'
autoprefixer = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'

path =
  src:
    html: './src/**/!(_)*.pug'
    css: './src/css/**/!(_)*.styl'
    js: './src/js/**/!(_)*.coffee'

  dest:
    html: './dest/'
    css: './dest/css'
    js: './dest/js'

gulp.task 'pug', () ->
  gulp.src ["#{path.src.html}"]
    .pipe pug()
    .pipe gulp.dest "#{path.dest.html}"

gulp.task 'stylus', () ->
  gulp.src ["#{path.src.css}"]
    .pipe stylus()
    .pipe autoprefixer()
    .pipe gulp.dest "#{path.dest.css}"

gulp.task 'coffee', () ->
  gulp.src ["#{path.src.js}"]
    .pipe coffee
      bare:true
    .pipe gulp.dest "#{path.dest.js}"

gulp.task 'build', ['pug', 'stylus', 'coffee']

gulp.task 'default', ['build']

