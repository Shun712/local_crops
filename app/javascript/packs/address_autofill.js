$(function () {
    $('#postcode').jpostal({
        postcode : [
            '#postcode'
        ],
        address : {
            '#address' : '%3%4%5'
        }
    });
});