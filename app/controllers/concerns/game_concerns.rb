module GameConcerns
  def clearmatches
    current_match = Match.where(user_id: current_user.id)
    current_match.first.delete unless current_match.empty?
  end

  def clearmatchesopponent(opponent_id)
    current_match = Match.where(user_id: opponent_id)
    current_match.first.delete unless current_match.empty?
  end

  def cleargames
    current_game = Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id))
    current_game.first.delete unless current_game.empty?
  end

  def clearall
    clearmatches
    cleargames
  end
end
