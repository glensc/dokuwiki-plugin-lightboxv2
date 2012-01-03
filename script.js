// load jquery.lightbox.js library
/* DOKUWIKI:include jquery-lightbox/jquery.lightbox.js */

// setup the hook on load event
jQuery(function($) {
	var jsonData = [];

	$('a[class=media]').each(function() {
		var img = $(this).find('img');
		if (img.length) {
			img = img[0];
			var url = img.src;

			// remove size specification
			url = url.replace(/\?w=\d+/, '');
			jsonData.push([url, img.title || '']);

			// rewrite .href, so lightbox could find active image from set
			// this is perhaps evil, but then again, we overtake click handler
			// anyway.
			this.href = url;
		} else {
			return false;
		}
	}).lightbox({
		fileLoadingImage: 'lib/plugins/lightbox/jquery-lightbox/images/loading.gif',
		fileBottomNavCloseImage: 'lib/plugins/lightbox/jquery-lightbox/images/closelabel.gif',
		fitToScreen: true,
		jsonData: jsonData,
		jsonDataParser: function(data) {
			return data;
		}
	});
})
