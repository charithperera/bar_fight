class GameController < ApplicationController

  def requestbattle
    new_game = Game.new
    new_game.opponent_id = params["opponentId"]
    new_game.challenger_id = current_user.id
    new_game.save
  end



  def beginbattle
    render :battle_screen
  end
end
