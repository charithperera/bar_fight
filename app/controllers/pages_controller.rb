class PagesController < ApplicationController

  def main
    @user_cards = current_user.cards
    @user = current_user
    @opponents = User.where(logged_in: true, in_game: false)

  end



end
