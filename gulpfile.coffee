gulp = require 'gulp'
pug = require 'gulp-pug'
stylus = require 'gulp-stylus'
autoprefixer = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
browserSync = require 'browser-sync'

path =
  src:
    html: './src/**/!(_)*.pug'
    css: './src/css/**/!(_)*.styl'
    js: './src/js/**/!(_)*.coffee'

  dest:
    html: './dest/'
    css: './dest/css'
    js: './dest/js'

tolerateError = (error) ->
  console.log error.toString()
  @emit('end')
  return

gulp.task 'pug', () ->
  gulp.src ["#{path.src.html}"]
    .pipe pug()
    .on 'error', tolerateError
    .pipe gulp.dest "#{path.dest.html}"
  return

gulp.task 'stylus', () ->
  gulp.src ["#{path.src.css}"]
    .pipe stylus()
    .on 'error', tolerateError
    .pipe autoprefixer()
    .pipe gulp.dest "#{path.dest.css}"
  return

gulp.task 'coffee', () ->
  gulp.src ["#{path.src.js}"]
    .pipe coffee
      bare:true
    .on 'error', tolerateError
    .pipe gulp.dest "#{path.dest.js}"
  return

gulp.task 'build', ['pug', 'stylus', 'coffee']

gulp.task 'src-watch', () ->
  gulp.watch "#{path.src.html}", ['pug']
  gulp.watch "#{path.src.css}", ['stylus']
  gulp.watch "#{path.src.js}", ['coffee']
  return

gulp.task 'dest-watch', () ->
  gulp.watch "#{path.dest.html}/**/*.*", ['browser-sync-reload']
  return

gulp.task 'browser-sync', () ->
  browserSync.init
    server:
      baseDir: 'dest',
      index: 'index.html'
  return

gulp.task 'browser-sync-reload', () ->
  browserSync.reload()
  return

gulp.task 'watch', ['build', 'browser-sync', 'src-watch', 'dest-watch'] 

gulp.task 'default', ['watch']

