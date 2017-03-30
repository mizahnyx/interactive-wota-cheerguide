var gulp = require('gulp');
var gulpPug = require('gulp-pug');
var connect = require('gulp-connect');
var gutil = require('gulp-util');
var coffeescript = require('gulp-coffeescript');
var data = require('gulp-data');
var less = require('gulp-less');

var TARGET_DIR = '../build/site';
 
gulp.task('coffee', function() {
    return gulp.src(['**/*.coffee', '!node_modules/**/*.coffee'])
        .pipe(coffeescript({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('less', function () {
    return gulp.src(['**/*.less', '!node_modules/**/*.less'])
        .pipe(less())
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('pug', function () {
    return gulp.src(['**/*.pug', '!node_modules/**/*.pug'])
        .pipe(data(function (file) {
            var filenameWithoutExtension = file.path.substr(0, file.path.lastIndexOf('.'));
            return require(filenameWithoutExtension + '.json');
        }))
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

gulp.task('default', ['coffee', 'less', 'pug']);

