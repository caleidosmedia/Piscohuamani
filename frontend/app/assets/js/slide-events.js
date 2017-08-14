function getGalleryIndex($collection, entry_id) {
        var _index = 0;
        $collection.each(function(index,element) {
                var data_entry = $(element).attr("data");
                if (data_entry == entry_id) {
                        _index = index;
                }
        });
        return _index;
}


$(document).ready(function() {

        var bShow = window.location.href.indexOf("/events") > 0;

	if (bShow) {
		var entry_id = localStorage.getItem("slide_id");
		/*var $gallery = $(".gallery-child").flickity();*/
		var $gallery_items = $gallery.find(".gallery-cell");
		var gallery_index = getGalleryIndex($gallery_items, entry_id);
		$gallery.flickity( 'select', gallery_index, false, true );

	}

});
