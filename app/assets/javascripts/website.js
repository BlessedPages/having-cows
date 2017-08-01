

// DOCUMENT FULLY LOAD
$(document).on("turbolinks:load", function() {

// FADE OUT ALERTS AFTER DISPLAYED //

var alertDisp = $('.alert')
	alertDisp.delay(5000).fadeOut(2000, function() {
		alertDisp.fadeOut();
	});

}); // END DOCUMENT-LOAD