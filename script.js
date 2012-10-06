// load jquery.lightbox.js library
/* DOKUWIKI:include jquery-lightbox/jquery.lightbox.js */

// setup the hook on load event
jQuery(function($) {
	var jsonData = [];

	$('a[class=media]').each(function() {
		var img = $(this).find('img');
		if (!img.length) {
			return false;
		}

		img = img[0];
		var url = img.src;

		// remove size specification
		// userewrite=0: /lib/exe/fetch.php?w=200&media=image.png, fetch.php?media=image.png
		// userewrite=1: /_media/image.png?w=200, /_media/image.png
		// userewrite=2: /lib/exe/fetch.php/image.png?w=200, /lib/exe/fetch.php/image.png
		url = url.replace(/\?w=\d+&?/, '?');
		jsonData.push([url, img.title || '']);

		// rewrite .href, so lightbox could find active image from set
		// this is perhaps evil, but then again, we overtake click handler
		// anyway.
		this.href = url;
	}).lightbox({
		fileLoadingImage: DOKU_BASE +'lib/plugins/lightbox/jquery-lightbox/images/loading.gif',
		fileBottomNavCloseImage: DOKU_BASE +'lib/plugins/lightbox/jquery-lightbox/images/closelabel.gif',
		fitToScreen: true,
		jsonData: jsonData,
		jsonDataParser: function(data) {
			return data;
		}
	});
})
