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
    assert_equal 52, game.draw_pile.count, "Game should have all cards"
    assert game.spent_pile.empty?, "No cards should have been discarded yet"
    assert game.number_of_roads > 7 && game.number_of_roads < 14, "Game should have more than seven but less than 14 roads"
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
    p1.draw_from game.draw_pile
    assert_equal 1, p1.hand.count, "A player gets a card"
    assert !game.spent_pile.include?(p1.hand.first)
  end
  
  def test_players_can_claim_a_road_with_exact_points
    p1 = @players.first
    game = @game
    points_required = game.number_of_roads
    number_of_roads_to_claim = 1
    card = Card.new(points_required, :H)
    p1.hand.send(:<<, card)

    assert_equal card, p1.hand.first, "Should have a card"

    assert p1.claim_road(game.roads, number_of_roads_to_claim, points_required), "Should be able to claim a road"
     
    assert_equal 1, p1.claimed_roads.count, "players should be able to claim a road"
    assert_equal 1, game.claimed_roads_count, "game should keep track of count of claimed roads"
  end
  
  def test_players_cannot_claim_a_road_without_exact_points
    p1 = @players.first
    game = @game
    points_required = game.number_of_roads
    number_of_roads_to_claim = 1
    card = Card.new(points_required+2, :H)
    p1.hand.send(:<<, card)

    assert_equal card, p1.hand.first, "Should have a card"

    assert !p1.claim_road(game.roads, number_of_roads_to_claim, points_required), "Should be able to claim a road"
     
    assert_equal 0, p1.claimed_roads.count, "players should be able to claim a road"
    assert_equal 0, game.claimed_roads_count, "game should keep track of count of claimed roads"
  end
  
end