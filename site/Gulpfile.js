var gulp = require('gulp');
var gulpPug = require('gulp-pug');

var TARGET_DIR = '../build/site';

gulp.task('pug', function () {
    return gulp.src(['**/*.pug', '!node_modules/**/*.pug'])
        .pipe(gulpPug({
            filename: '.pug',
            pretty: true,
            basedir: './'
        }))
        .pipe(gulp.dest(TARGET_DIR));
});

gulp.task('default', ['pug']);
