var gulp = require('gulp');
var gulpPug = require('gulp-pug');
var connect = require('gulp-connect');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var data = require('gulp-data');
var less = require('gulp-less');
var path = require('path');
var exec = require('child_process').exec;
var yaml = require('gulp-yaml');

var TARGET_DIR = '../build/site';
var EMSCRIPTEN_OUT = '../build/game.emscripten/bin';
var VERSION = '0.0.6 alfa'
var REVISION = ''

var PAGE_FUNCTIONS = {
	index: function () {}
};

gulp.task('copy:emscripten', function() {
    return gulp.src([
        path.join(EMSCRIPTEN_OUT, '**/*.pak'),
        path.join(EMSCRIPTEN_OUT, '**/*.data'),
        path.join(EMSCRIPTEN_OUT, '**/*.mem'),
        path.join(EMSCRIPTEN_OUT, '**/*.js')
    ])
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('copy:css', function() {
    return gulp.src(['**/*.css', '!node_modules/**/*.css'])
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('copy:cname', function() {
    return gulp.src(['**/CNAME', '!node_modules/**/CNAME'])
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('exec:revision', function(cb) {
    exec('git rev-list --count HEAD', function (err, stdout, stderr) {
        REVISION = stdout;
        console.log(stderr);
        cb(err);
    });
});

gulp.task('yaml', function() { 
    return gulp.src(['**/*.yml', '!node_modules/**/*.yml'])
        .pipe(yaml({ schema: 'DEFAULT_SAFE_SCHEMA' }))
        .pipe(gulp.dest(TARGET_DIR));
}); 

gulp.task('coffee', function() {
    return gulp.src(['**/*.coffee', '!node_modules/**/*.coffee'])
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('less', function () {
    return gulp.src(['**/*.less', '!node_modules/**/*.less'])
        .pipe(less())
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('pug', function () {
    return gulp.src([
        '**/*.pug',
        '!node_modules/**/*.pug',
        '!**/includes/**/*.pug'
    ])
        .pipe(data(function (file) {
            var filenameWithoutExtension = file.path.substr(0, file.path.lastIndexOf('.'));
            var d = require(filenameWithoutExtension + '.json');
            d.timestamp = (new Date()).toString();
            d.version = VERSION;
            d.revision = REVISION;
            return d;
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

gulp.task('default', [
    'copy:emscripten',
    'copy:css',
    'copy:cname',
    'exec:revision',
    'yaml',
    'coffee',
    'less',
    'pug']);

