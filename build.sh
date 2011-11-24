#!/bin/sh
# build bundle for installing into dokuwiki

js_compress() {
	for a in "$@"; do
		# compress
		shrinksafe -c $a > $a.tmp; mv $a.tmp $a
		# trim newlines
		tr -d '\r\n' < $a > $a.tmp; mv $a.tmp $a
		# check syntax
		js -C -f $a
	done
}

set -e

p=lightboxv2
v=$(cat VERSION | tr -d -)
tarball=$p-$v.tar.bz2

install -d build/$p
(
	cat js/prototype.js
	cat js/effects.js
	cat js/builder.js
	cat js/lightbox.js
) > build/$p/script.js

js_compress build/$p/script.js

cp -p AUTHORS VERSION build/$p
cp -p css/lightbox.css build/$p/screen.css
cp -a images build/$p
cd build/$p
rm images/bullet.gif
rm images/donate-button.gif
rm images/download-icon.gif
rm images/image-1.jpg
rm images/thumb-1.jpg
cd ..

tar -cjf ../$tarball $p
cd ..
rm -rf build
