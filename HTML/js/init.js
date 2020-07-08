'use strict';

$('#showNames').on('click', function() {
    console.log('showNames clicked');
    let target = $('#clist');
    if (!target.hasClass('active')) { target.addClass('active'); }
    console.log('showNames complete: ', target);
});

$('#client__list--toggle').on('click', function() {
    let target = $('#clist');
    if (target.hasClass('active')) { target.removeClass('active'); }
});
$('#clist').on('click', function() {
    let target = $('#clist');
    if (target.hasClass('active')) { target.removeClass('active'); }
});

