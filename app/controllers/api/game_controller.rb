class Api::GameController < ApplicationController
  include GameConcerns

  def getcollection
    user_cards = current_user.cards
    pityCard
    render json: user_cards
  end

  def pityCard
    user_cards = current_user.cards
    if user_cards.empty?
      current_user.cards << Card.all.sample
    end
  end

  def getstats
    user_stats = current_user.stat
    render json: user_stats
  end

  def opponents
    opponents = User.where(logged_in: true, in_game: false)
    render json: opponents
  end

  def choosecard
    response = {
      :ready => false
    }

    current_game = Game.find(params['gameId'])

    if current_user.id == current_game.challenger_id
      current_game.challenger_cardid = params["cardId"]
      current_game.challenger_powername = params["powerName"]
      current_game.challenger_powerval = params["powerVal"]

      unless current_game.opponent_cardid.nil?
        response[:ready] = true
        response[:challengerCard] = Card.find(current_game.challenger_cardid)
        response[:opponentCard] = Card.find(current_game.opponent_cardid)
      end
    else
      current_game.opponent_cardid = params["cardId"]
      current_game.opponent_powername = params["powerName"]
      current_game.opponent_powerval = params["powerVal"]

      unless current_game.challenger_cardid.nil?
        response[:ready] = true
        response[:challengerCard] = Card.find(current_game.challenger_cardid)
        response[:opponentCard] = Card.find(current_game.opponent_cardid)
      end
    end

    current_game.save
    response[:game] = current_game
    response[:myId] = current_user.id
    response[:username] = current_user.username

    render json: response

  end


  def findmatch
    response = {}
    opponent = nil
    if Match.where(user_id: current_user.id).empty? || Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id)).empty?
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
        clearmatches
        clearmatchesopponent(opponent_id)
      else
        game = Game.where(opponent_id: current_user.id).or(Game.where(challenger_id: current_user.id)).first
      end
      response[:game] = game
      response[:cards] = current_user.cards.sample(3)
    end
    render json: response
  end

  def calculatewinner
    response = {
      :youwon => false
    }
    game = params[:game]
    challenger_powername = game[:challenger_powername]
    challenger_powerval = game[:challenger_powerval].to_i
    opponent_powername = game[:opponent_powername]
    opponent_powerval = game[:opponent_powerval].to_i

    if challenger_powerval > opponent_powerval
      challenger = User.find(game[:challenger_id])
      opponent = User.find(game[:opponent_id])

      challenger_stat = challenger.stat
      challenger_stat.wins += 1
      challenger_stat.save

      opponent_stat = opponent.stat
      opponent_stat.losses += 1
      opponent_stat.save

      response[:username] = challenger.username
      response[:powername] = challenger_powername
      response[:powerval] = challenger_powerval

      if challenger.id == current_user.id

        response[:youwon] = true
        response[:winnerpic] = Card.find(game["challenger_cardid"]).image_url
      else
        response[:loserpic] = Card.find(game["opponent_cardid"]).sad_image_url
        lose_card = Card.find(game[:opponent_cardid])
        challenger.cards << lose_card
        opponent.cards.delete(lose_card)
      end

    else
      opponent = User.find(game[:opponent_id])
      challenger = User.find(game[:challenger_id])

      challenger_stat = challenger.stat
      challenger_stat.losses += 1
      challenger_stat.save

      opponent_stat = opponent.stat
      opponent_stat.wins += 1
      opponent_stat.save

      response[:username] = opponent.username
      response[:powername] = opponent_powername
      response[:powerval] = opponent_powerval

      if opponent.id == current_user.id
        response[:youwon] = true
        response[:winnerpic] = Card.find(game["opponent_cardid"]).image_url
      else
        response[:loserpic] = Card.find(game["challenger_cardid"]).sad_image_url
        lose_card = Card.find(game[:challenger_cardid])
        opponent.cards << lose_card
        challenger.cards.delete(lose_card)
      end
    end
    response[:nocards] = current_user.cards.empty?
    render json: response
  end


end
# //need to delete rows in Match table
