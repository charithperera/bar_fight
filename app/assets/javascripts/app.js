$(document).ready(function() {
  $('#opponent-btn').click(function(event) {
    //destroy children of list
    $('.opponent-list').empty();
    //build a list of opponents

    $.ajax({
      url: '/api/getopponents',
      method: 'get'
    })
    .done(getOpponents)
    //append them to the OPPONENT LIST class

  });

  function getOpponents(response) {
    for (var i = 0; i < response.length; i++) {
      $('<li>', {
        text: response[i].username,
        'data-user-id': response[i].id
      }).appendTo($('.opponent-list'))
    }

  }

  $(".opponent-list").on("click", "li", function(e) {
    $.ajax({
      url:
    })
  })
});
