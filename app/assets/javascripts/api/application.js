// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/modal
//= require spin
//= require jquery.spin
//= require_tree .

$(function() {
    $('html').on('click', function(e) {
        var $element = $(e.target);
        var hrefValue = $element.attr('href') || "";
        var hasDataToggle = $element.attr('data-toggle') != "";

        if (hasDataToggle) { return; }

        if ($element.is("A") && (hrefValue == '' || hrefValue == '#')) {
            e.preventDefault();
        }

        e.stopPropagation();
    });

    $('#response-objects').find('a').on('click', function(e) {
        var $link = $(this);
        var $modal = $('#recourse-modal');
        var $modalHeader = $('.modal-header', $modal);
        var $modalTitle = $('h3', $modalHeader);
        var $modalBody = $('.modal-body', $modal);
        var opts = {
            lines: 9,   // The number of lines to draw
            length: 5,  // The length of each line
            width: 3,   // The line thickness
            radius: 7,  // The radius of the inner circle
            top: 0,     // Top position relative to parent in px
            left: 470   // Left position relative to parent in px
        };

        $modalTitle.text($link.text().trim() + " Response");
        $modalBody.html('');
        var spinner = $modalHeader.spin(opts);

        $modalBody.load($link.attr('href'), function() {
            spinner.spin(false);
        });

        $modal.on('show', function() {
            $('html, body')
                .css('overflow', 'hidden')
                .css('max-height', window.innerHeight);
        });

        $modal.on('shown', function() {
            $('.modal-backdrop').on('touchstart', function(e) {
                e.preventDefault();
            });
        });

        $modal.on('hide', function() {
            $('html, body').attr('style', '');
        });

        $modal.modal({
            toggle: 'modal'
        });

        e.preventDefault();
        e.stopPropagation();
    });
});