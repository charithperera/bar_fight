module GameConcerns
  def clearcurrentgame
    current_game = Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id))
    current_game.first.delete unless current_game.empty?
    current_match = Match.where(user_id: current_user.id)
    current_match.first.delete
  end
end
