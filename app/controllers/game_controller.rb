class GameController < ApplicationController

  def requestbattle
    new_game = Game.new
    new_game.opponent_id = params["opponentId"]
    new_game.challenger_id = current_user.id
    new_game.save
    binding.pry
  end

  def setready
    binding.pry
    if Match.where(user_id: current_user.id).empty?
      Match.create(user_id: current_user.id)
    end
  end

  def acceptbattle
    # update user to say in game
  end

  def beginbattle
    render :battle_screen
  end
end
