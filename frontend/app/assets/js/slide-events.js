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
		var $gallery = $(".gallery-child").flickity();
		var $gallery_items = $gallery.find(".gallery-cell");
		var gallery_index = getGalleryIndex($gallery_items, entry_id);
		$('.events-slide[data-current="1"]').attr("data-current", 0);
		$('.events-slide[data-index=' + (gallery_index + 1) + ']').attr("data-current", 1);
		$('.ronda-1[data-current=1]').attr("data-current", 0);
		$('.ronda-1[data-index=' + (gallery_index + 1) + ']').attr("data-current", 1);
		$gallery.flickity( 'select', gallery_index, false, true ); 

		mostrarContenido("#container-ronda", ".ronda-1");
		slide(".gallery-button-right", "next", "translate-left", "#container-ronda", ".ronda-1");
		slide(".gallery-button-left", "back", "translate-right", "#container-ronda", ".ronda-1");
	}

});
