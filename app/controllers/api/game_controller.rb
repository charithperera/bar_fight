class Api::GameController < ApplicationController

  def collection
    user_cards = current_user.cards
    render json: user_cards
  end


  def opponents
    opponents = User.where(logged_in: true, in_game: false)
    render json: opponents
  end

  def requestbattle
    binding.pry
  end

  def acceptbattle
  end

  def beginbattle
    render :battle_screen
  end

  def findmatch
    response = {}
    opponent = nil
    if Match.where(user_id: current_user.id).empty?
      Match.create(user_id: current_user.id)
    end
    users_looking = Match.where.not(user_id: current_user.id)
    unless users_looking.empty?
      opponent_id = users_looking.sample.user_id
      game = nil
      if Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id)).empty?
        game = Game.new
        game.challenger_id = current_user.id
        game.opponent_id = opponent_id
        game.save
      else
        game = Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id)).first
      end
      response[:game] = game
      response[:cards] = current_user.cards.sample(3)
    end
    render json: response
  end
end
