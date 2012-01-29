#!/bin/sh
# build bundle for installing into dokuwiki

js_compress() {
	local js
	for js in "$@"; do
		# compress
		closure-compiler --js $js --charset UTF-8 --js_output_file $js.tmp
		mv $js.tmp $js
		# check syntax
		js -C -f $js
	done
}

css_compress() {
	local css
	for css in "$@"; do
		yuicompressor --charset UTF-8 --type css $css -o $css.tmp
		mv $css.tmp $css
	done
}

set -e

p=lightbox
v=$(awk '/^date/{print $2}' plugin.info.txt)
zipball=$p-$v.zip

install -d build/$p/images

# include "jquery.lightbox.js" to "script.js"
sed -re '
/\/\* DOKUWIKI:include (.+) \*\//{
	r jquery-lightbox/jquery.lightbox.js
	d
}

# use own imagedir
s#lib/plugins/lightbox/jquery-lightbox/images/#lib/plugins/lightbox/images/#;

' script.js > build/$p/script.js
js_compress build/$p/script.js

# replace images path in css
sed -e '
	s#\.\./images/#images/#g
' jquery-lightbox/css/lightbox.css > build/screen.css

# include "lightbox.css" into "screen.css"
sed -re '/@import url\(jquery-lightbox\/css\/lightbox.css\);/{
	r build/screen.css
	d
} ' screen.css > build/$p/screen.css
css_compress build/$p/screen.css

# images referred from css
cp -p jquery-lightbox/images/{blank.gif,prev.gif,next.gif} build/$p/images

# images referred from .js
cp -p jquery-lightbox/images/{loading.gif,closelabel.gif} build/$p/images

# docs
cp -p AUTHORS plugin.info.txt build/$p
# dummy file, needed for plugin info to work
cp -p helper.php build/$p

# setup sane perms
chmod -R a+rX build/$p
find build/$p -type f | xargs chmod a-x

# zip it up
cd build
zip ../$zipball -r $p
cd ..

# and cleanup
rm -rf build
