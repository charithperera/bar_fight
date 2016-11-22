class PagesController < ApplicationController

  def main
    @user_cards = current_user.cards
    render json: user_cards
  end

end
