class GameController < ApplicationController
  def collection
  end

  def opponents
  end

  def requestbattle
  end

  def acceptbattle
  end

  def beginbattle
    render :battle_screen
  end
end
