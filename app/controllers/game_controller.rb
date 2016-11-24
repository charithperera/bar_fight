class GameController < ApplicationController
  include GameConcerns

  def requestbattle
    new_game = Game.new
    new_game.opponent_id = params["opponentId"]
    new_game.challenger_id = current_user.id
    new_game.save
<<<<<<< HEAD
=======

  end

  def acceptbattle
    # update user to say in game
>>>>>>> e2d344cad087653762becb2e2d7e25303c544dba
  end

  def beginbattle
    render :battle_screen
  end
end
