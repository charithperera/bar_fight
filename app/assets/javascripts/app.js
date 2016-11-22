$(document).ready(function() {

  $("#btn-find-match").click(function(e) {
    findMatch();
  })

  $(".my-cards").on("click", ".ui-card", function(e) {
    var idClicked = $(e.target).closest(".ui-card").attr("data-id");
    
  });

  function findMatch() {
    $.ajax({
      url: "/api/findmatch",
      method: "post"
    })
    .done(function(resp){
      if (resp.game) {
        renderGame(resp);
      }
      else {
        setTimeout(function () {
            findMatch();
        }, 5000);
      }
    })
  }

  function renderGame(gameData) {
    var cards = gameData.cards
    var source = $("#card-template").html();
    var template = Handlebars.compile(source);
    for (var i = 0; i < cards.length; i++) {
      $(".my-cards").append(template(cards[i]))
    }
  }


  // $('#opponent-btn').click(function(event) {
  //   //destroy children of list
  //   $('.opponent-list').empty();
  //   //build a list of opponents
  //
  //   $.ajax({
  //     url: '/api/getopponents',
  //     method: 'get'
  //   })
  //   .done(getOpponents)
  //   //append them to the OPPONENT LIST class
  //
  // });
  //
  // function getOpponents(response) {
  //   for (var i = 0; i < response.length; i++) {
  //     $('<li>', {
  //       text: response[i].username,
  //       'data-user-id': response[i].id
  //     }).appendTo($('.opponent-list'))
  //   }
  //
  // }

});
