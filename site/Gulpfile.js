var gulp = require('gulp');
var gulpPug = require('gulp-pug');
var connect = require('gulp-connect');
var gutil = require('gulp-util');
var coffeescript = require('gulp-coffeescript');

var TARGET_DIR = '../build/site';
 
gulp.task('coffee', function() {
    gulp.src(['**/*.coffee', '!node_modules/**/*.coffee'])
        .pipe(coffeescript({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('pug', function () {
    return gulp.src(['**/*.pug', '!node_modules/**/*.pug'])
        .pipe(gulpPug({
            filename: '.pug',
            pretty: true,
            basedir: './'
        }))
        .on('error', gutil.log)
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('connect', function() {
    connect.server({
        root: TARGET_DIR,
        livereload: true
    });
});

gulp.task('default', ['coffee', 'pug']);
