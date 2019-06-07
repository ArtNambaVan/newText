// Gulp & plugins
const gulp           = require('gulp'),

    // gulp plugins
    changed         = require('gulp-changed'),
    imagemin        = require('gulp-imagemin'),
    concat          = require('gulp-concat'),
    uglify          = require('gulp-uglify'),
    less            = require('gulp-less'),
    plumber         = require('gulp-plumber'),
    nunjucksRender  = require('gulp-nunjucks-render'),
    data            = require('gulp-data'),
    cleanCSS        = require('gulp-clean-css'),
    sourcemaps      = require('gulp-sourcemaps'),
    sass            = require('gulp-sass'),
    autoprefixer    = require('gulp-autoprefixer'),
    

    // other plugins
    LessAutoPrefix  = require('less-plugin-autoprefix'),
    browsersync     = require('browser-sync'),
    del             = require('del'),
    fs              = require('graceful-fs');

    sass.compiler   = require('node-sass'),
    liferayThemeTasks = require('liferay-theme-tasks');

    liferayThemeTasks.registerTasks(
    	{
    		gulp: gulp
    });
//let requireUncached = require('require-uncached'),

// Files path
let PATH;

PATH = {
  src  : './uidev/src/',
  dest : './uidev/html/'
};

PATH.njk = {
  njk : PATH.src + 'uidev/src/_templates/**/*.njk',
  in : PATH.src + 'uidev/src/_pages/**/*.njk',
  out : PATH.dest + './uidev/'
};

PATH.html = {
  in  : PATH.src  + '*./uidev/src/html',
  out : PATH.dest + './uidev/src/'
};

PATH.images = {
  in  : PATH.src  + 'uidev/src/images/**/*.*',
  out : PATH.dest + 'uidev/src/images/'
};

PATH.css_libs = {
    in  : PATH.src  + 'uidev/src/css/libs/',
    out : PATH.dest + 'uidev/src/css/libs/'
};

PATH.less = {
    all : PATH.src  + 'uidev/src/css/style.less',
    in  : PATH.src  + 'uidev/src/css/**/*.less',
    out : PATH.dest + 'uidev/src/css/'
};

PATH.sass = {
    all : PATH.src + 'uidev/src/css/*.scss',
    in  : PATH.src + 'uidev/src/css/**/*.scss',
    out : PATH.dest + 'uidev/src/css/'
}

PATH.fonts = {
  in  : PATH.src  + 'uidev/src/fonts/**/*.*',
  out : PATH.dest + 'uidev/src/fonts/'
};

PATH.js = {
    in  : './src/main/webapp/js/modules',
    out : PATH.dest + 'uidev/src/js/'
}

PATH.js_libs = {
  in  : './target/build-theme/js/vendors/',
  out : './target/build-theme/js/'
};

const SYNC_CONFIG = {
    port   : 3333,
    browser: "chrome",
    server : {
      baseDir : PATH.dest,
      //index : 'promotion-rules.html'
      index : 'index.html'
    },
    open   : true,
    notify : false
  };



// LESS options
var LESS_PREFIXER = new LessAutoPrefix({
        browsers: ['last 5 versions', 'ie 11', 'Firefox 14']
    });

var SASS_PREFIXER = {
    browsers: ['last 5 versions', 'ie 11', 'Firefox 14']
    };

// NUNJUCKS options
var NUNJUCKS_DEFAULTS = {
    path: 'uidev/src/_templates/',
    envOptions: {
        watch: false,
        trimBlocks: true,
        lstripBlocks: true
    }
};

// handle styles
gulp.task('css', function() {
    // console.log('*************************');
    // console.log('*** Starting CSS task ***');
    // console.log('*************************');

    return gulp.src(PATH.css.in)
        .pipe(gulp.dest(PATH.css.out))
        ;
});

gulp.task('css_libs', function() {
    return gulp.src([
            PATH.css_libs.in + 'clay.css',
            PATH.css_libs.in + 'main.css'
        ])
        //.pipe(concat('libs.css'))
        .pipe(gulp.dest(PATH.css_libs.out))
    ;
  });

gulp.task('sass', function() {
    return gulp.src(PATH.sass.all)
        .pipe(sass.sync().on('error', sass.logError))
        .pipe(autoprefixer(SASS_PREFIXER))
        .pipe(gulp.dest(PATH.sass.out))
})


gulp.task('styles', ['sass', 'css_libs']);

// handle fonts
gulp.task('fonts', function(){
    // console.log('***************************');
    // console.log('*** Starting FONTS task ***');
    // console.log('***************************');

    return gulp.src(PATH.fonts.in)
        .pipe(gulp.dest(PATH.fonts.out))
        ;
});

// handle images
gulp.task('images', function() {
    // console.log('****************************');
    // console.log('*** Starting IMAGES task ***');
    // console.log('****************************');

    return gulp.src(PATH.images.in)
        .pipe(changed(PATH.images.out))
        .pipe(imagemin())
        .pipe(gulp.dest(PATH.images.out))
        ;
});


gulp.task('pictures', ['images']);

// handle js
gulp.task('js', function() {
    // console.log('************************');
    // console.log('*** Starting JS task ***');
    // console.log('************************');

    return gulp.src([
			PATH.js.in + 'modules/'
		])
        .pipe(concat('mainapp.es.js'))
        // .pipe(uglify())
        .pipe(gulp.dest(PATH.js.out))
        ;
});

gulp.task('js_libs', function() {
    return gulp.src([
        PATH.js_libs.in + 'vue.runtime.min.js',

/*
			PATH.js_libs.in + 'bootstrap.js',
			PATH.js_libs.in + 'vue/vue.common.js'
            PATH.js_libs.in + 'jquery.js',
            PATH.js_libs.in + 'popper.js',
            PATH.js_libs.in + 'bootstrap.js',
            PATH.js_libs.in + 'bootstrap-select.js',
            PATH.js_libs.in + 'jstree.min.js'
*/
        ])
        .pipe(concat('libs.js'))
        .pipe(uglify())
        .pipe(gulp.dest(PATH.js_libs.out))
    ;
  });

// handle nunjucks
gulp.task('nunjucks', function() {
    //let data = requireUncached('./src/_data/data.json');
    return gulp.src(PATH.njk.in)
        .pipe(changed(PATH.njk.out))
        .pipe(data(function (file) {
            DEBUG:
            var test = fs.readFileSync('./uidev/src/_data/data.json', 'utf8');
            var json = JSON.parse(fs.readFileSync('./uidev/src/_data/data.json', 'utf8'));
            console.log("test: ", test);
            console.log("json: ", json);
            return JSON.parse(fs.readFileSync('./uidev/src/_data/data.json', 'utf8'));
        }))
        .pipe(nunjucksRender(NUNJUCKS_DEFAULTS))
        .pipe(gulp.dest(PATH.njk.out))
        ;
});



// handle html
gulp.task('html', ['nunjucks'], function() {
    return gulp.src(PATH.html.in)
        .pipe(changed(PATH.html.out))
        .pipe(gulp.dest(PATH.html.out))
        ;
});

// build task
gulp.task('build',

    [   
//    	'styles',
//        'fonts',
//        'pictures',
        'js_libs'
//        'js',
//        'html'
    ],

    function() {
        console.log('***************************');
        console.log('*** Starting BUILD task ***');
        console.log('***************************');
    }
);

// clean html folder
gulp.task('clean', function() {
    console.log('***************************');
    console.log('*** Starting CLEAN task ***');
    console.log('***************************');
    del([
        PATH.dest + '*'
    ]);
});

// Browser-sync task
gulp.task('browsersync', function() {
    browsersync(SYNC_CONFIG);
});


// default task
gulp.task('default', ['build']);