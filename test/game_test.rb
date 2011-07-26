require_relative 'test_helper'
class GameTest < Test::Unit::TestCase

  def setup
    @players = create_two_players
    @game = Game.new @players
  end

  def test_game_initialization
    players = @players
    game = @game

    assert_equal players, game.players, "A game should have players"
    assert players.first.game, "A player knows about the game"
    assert_equal 52, game.draw_pile.count, "Game should have all cards"
    assert game.spent_pile.empty?, "No cards should have been discarded yet"
    assert game.cost_to_claim_a_road > 7 && game.cost_to_claim_a_road < 14, "Game should have more than seven but less than 14 roads"
    assert_equal 0, game.claimed_roads_count, "Game should start with zero roads claimed"

    game.roads.each do |road,claim|
      game.roads[road] = true
    end
    assert_equal game.roads.count, game.claimed_roads_count, "Claimed roads should reflect number of roads claimed"
    assert game.over?, "Game ends when all roads are claimed"
  end

  def test_players_can_draw_cards
    p1 = @players.first
    game = @game

    assert p1.hand.empty?, "A player starts with an empty hand"
    p1.draw_card
    assert_equal 1, p1.hand.count, "A player gets a card"
    assert !game.spent_pile.include?(p1.hand.first)
  end

  def test_players_can_claim_a_road_with_exact_points
    p1 = @players.first
    game = @game
    points_required = game.cost_to_claim_a_road
    number_of_roads_to_claim = 1
    card = Card.new(points_required, :H)
    p1.hand.send(:<<, card)

    assert_equal card, p1.hand.first, "Should have a card"

    assert p1.claim_roads(number_of_roads_to_claim), "Should be able to claim a road"

    assert_equal 1, p1.claimed_roads.count, "Players should be able to claim a road"
    assert_equal 1, game.claimed_roads_count, "Game should keep track of count of claimed roads"
    assert_equal 1, game.spent_pile.count, "Game should keep track of cards spent"
    assert_equal 0, p1.hand.count, "Player should spend cards to claim roads"
  end

  def test_players_can_claim_a_road_with_combinations_of_cards
    p1 = @players.first
    game = @game
    game.instance_eval do
      @cost_to_claim_a_road = 10
    end
    points_required = game.cost_to_claim_a_road
    
    # got a few cards up my sleeve... heh.
    %W{7 9 A}.map{ |v| Card.new(v,:H) }.each do |card|
      p1.hand.send(:<<, card)
    end
    
    assert p1.claim_roads(1), "Should be able to claim a road using 9H + AH"
    assert_equal 1, p1.claimed_roads.count, "Players should be able to claim a road"
    assert_equal 1, game.claimed_roads_count, "Game should keep track of count of claimed roads"
    assert_equal 2, game.spent_pile.count, "Game should keep track of cards spent"
    assert_equal 1, p1.hand.count, "Player should spend cards to claim roads"
  end


  def test_players_cannot_claim_a_road_without_exact_points
    p1 = @players.first
    game = @game
    points_required = game.cost_to_claim_a_road
    number_of_roads_to_claim = 1
    card = Card.new(points_required-7, :H)
    p1.hand.send(:<<, card)

    assert_equal card, p1.hand.first, "Should have a card"
    assert !p1.claim_roads(number_of_roads_to_claim), "Should not be able to claim a road"

    assert_equal 0, p1.claimed_roads.count, "Player should not have any claimd roads"
    assert_equal 0, game.claimed_roads_count, "Game should keep track of count of claimed roads"
  end

  def test_a_game_will_tell_you_who_won
    p1,p2 = @players[0],@players[1]
    game = @game

    points_required = game.cost_to_claim_a_road
    number_of_roads_to_claim = 2
    [Card.new(points_required, :H),Card.new(points_required, :S)].each do |card|
      p1.hand.send(:<<, card)
    end

    p2.hand.send(:<<, Card.new(points_required, :D))

    assert_equal 2, p1.hand.count, "Player one should have two cards"
    assert_equal 1, p2.hand.count, "Player two should have one card"

    assert p1.claim_roads(2), "Player one should be able to claim two roads"
    assert_equal 2, p1.claimed_roads.count, "Player one should have two claimed roads"
    assert_equal 2, game.claimed_roads_count, "Game should know it has two claimed roads"
    
    assert p2.claim_roads(1), "Player two should be able to claim one road"
    assert_equal 1, p2.claimed_roads.count, "Player two should have one claimed road"
    assert_equal 3, game.claimed_roads_count, "Game should know it has three claimed roads"
    
    # cheat a little and make the game think it's over...
    game.roads.keys.each do |path|
      p1.claimed_roads.send(:<<, path) unless game.roads[path]
      game.roads[path] = p1 unless game.roads[path]
    end
    
    assert_equal 1, p2.claimed_roads.count, "Player two should still have one claimed road"
    assert_equal game.roads.count - 1, p1.claimed_roads.count, "Player one has a shitload of claimed roads"
    assert_equal p1, game.winner, "Player one should win"
  end
  
  def test_if_all_cards_have_been_drawn_game_reshuffles
    game = @game
    p1 = @players.first
    51.times do
      p1.draw_card
    end

    assert_equal 51, p1.hand.count, "Player should have drawn 51 cards"
    assert_equal 1, game.draw_pile.count, "Game should have one card left"

    p1.draw_card
    assert_equal 52, p1.hand.count, "Player should have drawn 52 cards"
    assert_equal 0, game.draw_pile.count, "Game should have no cards left"

    p1.draw_card

    assert_equal 53, p1.hand.count, "Player should have drawn 53 cards"
    assert_equal 51, game.draw_pile.count, "Game should have 51 cards left"
  end

end