class GameController < ApplicationController

  def requestbattle
  end

  def acceptbattle
  end

  def beginbattle
    render :battle_screen
  end
end
