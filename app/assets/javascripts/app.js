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
      url: '/requestbattle',
      method: 'post',
      data: {
        opponentId: $(this).attr("data-user-id")
      }
    })
  }).done(standby)

  function standby() {
  }

  $(".opponent-list").on("click", function(e) {
    $.ajax({
      url:'api/findmatch',
      method: 'post',
    })
  }).done(awaitMatch)

  function awaitMatch(response) {
    //reload ajax call every five seconds?
  }

});

(function worker() {
  $.ajax({
    url: 'ajax/test.html',
    success: function(data) {
      $('.result').html(data);
    },
    complete: function() {
      // Schedule the next request when the current one's complete
      setTimeout(worker, 5000);
    }
  });
})();
