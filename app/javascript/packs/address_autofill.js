$(function () {
    $('#postcode').jpostal({
        postcode : [
            '#postcode'
        ],
        address : {
            '#city' : '%3%4%5'
        }
    });
});