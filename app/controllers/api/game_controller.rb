class Api::GamesController < ApplicationController

  def collection
    @user_cards = current_user.cards
    render json: user_cards
  end


  def opponents
    opponents = User.where(logged_in: true, in_game: false)
    render json: opponents
  end

  def requestbattle


  end

  def acceptbattle
  end

  def beginbattle
    render :battle_screen
  end
end
