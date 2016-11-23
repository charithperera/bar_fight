



$(document).ready(function(){

var $newGameBtn = $('#newgame');
var $dashBoardBtn = $('#dashboard');
var $exitGameBtn = $('#exitgame');
var $menu = $('.menu');
var $dashBoardScreen = $(".dashboard");
var $newGameScreen = $(".newgame");
var $returnBtn1 = $("#returnFromDashboard");
var $returnBtn2 = $("#returnFromGame");

$newGameBtn.on('click', function(e){
  $menu.toggle();
  $newGameScreen.toggle();
})

$dashBoardBtn.on('click', function(e){
  $menu.toggle();
  $dashBoardScreen.toggle();
})

$exitGameBtn.on('click', function(e){
  console.log(e.target);
  // logout and return to home

})

$returnBtn1.on('click', function(e){
  $menu.toggle();
  $dashBoardScreen.toggle();
})

$returnBtn2.on('click', function(e){
  $menu.toggle();
  $newGameScreen.toggle();
})
})
