$(document).ready(function() {

  var $dashBoardScreen = $(".dashboard");
  var $dashBoardBtn = $('#dashboard');
  var $newGameBtn = $('#newgame');
  var $exitGameBtn = $('#exitgame');
  var $menu = $('.menu');
  var $newGameScreen = $(".newgame");
  var $returnBtn1 = $("#returnFromDashboard");
  var $returnBtn2 = $("#returnFromGame");


  $newGameBtn.on('click', function(e){
    $menu.toggle();
    $newGameScreen.toggle();
    playMusic();
  })


  $returnBtn1.on('click', function(e){
    $menu.toggle();
    $dashBoardScreen.toggle();
    playMusic();

  })

  $returnBtn2.on('click', function(e){
    $menu.toggle();
    $newGameScreen.toggle();
    playMusic();

  })

  $dashBoardBtn.on('click', function(e){
    $menu.toggle();
    $dashBoardScreen.toggle();
    renderCollection();
    renderStats();
    playMusic();
  })


  $("#newgame").click(function(e) {
    findMatch();
  })

  $(".my-battle-cards").on("click", ".power", selectPower);

  function selectPower(e) {
    $(e.target).closest(".ui-card").css("transform", "scale(1.1)");
    $(e.target).closest(".power").css("border", "3px solid gold");
    $(".my-battle-cards").off("click", ".power");
    data = {
      powerName: $(e.target).closest("div").find("h4").text(),
      powerVal: $(e.target).closest("div").find("span").text(),
      cardId: $(e.target).closest(".ui-card").attr("data-id"),
      gameId: $(e.target).closest("#game").find(".game-header").attr("data-game-id")
    }
    chooseCard(data);
  }


  $(".finish").on("click", goToCollection);

  function chooseCard(data){
    $.ajax({
      url: '/api/choosecard',
      method: 'post',
      data: data
    })
    .done(function(res){
      if (res.ready) {
        $('.play-card-screen').toggle();
        $('.battle-screen').toggle();
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
    setTimeout(function(){
      displayWin(battleData);
    },10000);
  }

  function findMatch() {
    $.ajax({
      url: "/api/findmatch",
      method: "post"
    })
    .done(function(resp){
      if (resp.game) {
        $('.newgame').toggle();
        $('.play-card-screen').toggle();
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
      $(".my-battle-cards").append(template(cards[i]))
    }
  }

  function renderCollection() {
    $.ajax({
      url: '/api/getcollection',
      method: 'get'
    })
    .done(function(res) {
      var cards = res
      var source = $("#card-template").html();
      var template = Handlebars.compile(source);
      for (var i = 0; i < cards.length; i++) {
        $(".my-cards").append(template(cards[i]))
      }
    });
  }

  function renderStats() {
    $.ajax({
      url: '/api/getstats',
      method: 'get'
    })
    .done(function(res) {
      var source = $("#stats-template").html();
      var template = Handlebars.compile(source);
      $(".stats").append(template(res));
    })
  }

  function renderWin(winData) {
    if (winData.youwon) {
      $('.september').get(0).pause();
      $(".outcome").text("YOU WON!");
      $('.cheers').get(0).play();
      $(".card-outcome").text("You captured your opponent's card!");
    } else {
      $('.september').get(0).pause();
      $(".outcome").text("YOU LOSE!");
      $('.boos').get(0).play();
      $(".card-outcome").text("You lost your card!");
      if (winData.nocards) {
        $(".no-cards").toggle();
      }

    }
  }


  function goToCollection() {
    $('.winner-screen').toggle();
    $('.stats').empty();
    $('.my-cards').empty();
    renderCollection();
    renderStats();
    clearAll();
    $(".my-battle-cards").on("click", ".power", selectPower);
    $(".my-battle-cards").empty();
    $(".your-card").empty();
    $(".opponent-card").empty();


    $('.dashboard').toggle();
  }

  function displayWin(battleData) {
    $('.battle-screen').toggle();
    $('.winner-screen').toggle();
    $.ajax({
      url: "/api/calculatewinner",
      method: "post",
      data: battleData
    })
    .done(renderWin)
  }

  function clearAll() {
    $.ajax({
        type: 'POST',
        url: '/clearall',
        async:false
    });
  }

  $(window).unload(clearAll);

  function playMusic() {
    if ($('.september').get(0).paused) {
      $('.september').get(0).play();
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
