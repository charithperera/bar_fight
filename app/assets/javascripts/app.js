$(document).ready(function() {

  $("#newgame").click(function(e) {
    findMatch();
  })


  $(".my-cards").on("click", ".power", function(e) {
    data = {
      powerName: $(e.target).closest("div").find("h4").text(),
      powerVal: $(e.target).closest("div").find("span").text(),
      cardId: $(e.target).closest(".ui-card").attr("data-id"),
      gameId: $(e.target).closest("#game").find(".game-header").attr("data-game-id")
    }
    chooseCard(data)
  })

  function chooseCard(data){
    $.ajax({
      url: '/api/choosecard',
      method: 'post',
      data: data
    })
    .done(function(res){
      if (res.ready) {
        renderBattleScreen(res)
      }
      else {
        setTimeout(function () {
            chooseCard(data);
        }, 5000);
      }
    })
  }

  function renderBattleScreen(battleData) {
    var myBattleCard, oppBattleCard;

    if (battleData.myId == battleData.game.challenger_id) {
      myBattleCard = {
        username: battleData.username,
        name: battleData.challengerCard.name,
        special: battleData.challengerCard.special,
        image_url: battleData.challengerCard.image_url,
        powername: battleData.game.challenger_powername,
        powerval: battleData.game.challenger_powerval
      }

      oppBattleCard = {
        username: battleData.username,
        name: battleData.opponentCard.name,
        special: battleData.opponentCard.special,
        image_url: battleData.opponentCard.image_url,
        powername: battleData.game.opponent_powername,
        powerval: battleData.game.opponent_powerval
      }
    }
    else {
      myBattleCard = {
        username: battleData.username,
        name: battleData.opponentCard.name,
        special: battleData.opponentCard.special,
        image_url: battleData.opponentCard.image_url,
        powername: battleData.game.opponent_powername,
        powerval: battleData.game.opponent_powerval
      }

      oppBattleCard = {
        username: battleData.username,
        name: battleData.challengerCard.name,
        special: battleData.challengerCard.special,
        image_url: battleData.challengerCard.image_url,
        powername: battleData.game.challenger_powername,
        powerval: battleData.game.challenger_powerval
      }
    }
    var source = $("#battle-card-template").html();
    var template = Handlebars.compile(source);
    $(".your-card").append(template(myBattleCard));
    $(".opponent-card").append(template(oppBattleCard));

    //after 5 seconds, get win
    displayWin(battleData);
  }

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
    $(".game-header").attr("data-game-id", gameData.game.id);
    for (var i = 0; i < cards.length; i++) {
      $(".my-cards").append(template(cards[i]))
    }
  }

  function renderWin(winData) {
    if (winData.youwon) {
      $(".outcome").text("YOU WON!");
    } else {
      $(".outcome").text("YOU LOSE!");
    }
  }

  function displayWin(battleData) {
    $.ajax({
      url: "/api/calculatewinner",
      method: "post",
      data: battleData
    })
    .done(renderWin)
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
