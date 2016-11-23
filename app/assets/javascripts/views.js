



$(document).ready(function(){

var $newGameBtn = $('#newgame');
var $dashBoardBtn = $('#dashboard');
var $exitGameBtn = $('#exitgame');
var $menu = $('.menu');
var $dashBoardScreen = $(".dashboard");
var $newGameScreen = $(".newgame");


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

})
