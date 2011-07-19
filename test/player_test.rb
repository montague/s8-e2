require_relative 'test_helper'
class PlayerTest < Test::Unit::TestCase

  def test_a_player_can_draw_a_card

  end
  
  def test_a_player_can_claim_one_or_more_roads
  end
  
  def test_a_player_cannot_claim_a_road_without_exact_change
  end
  
  def test_all_possible_counts
    p = Player.new(:ian)
    [Card.new(1,:H), Card.new(2,:H), Card.new(3,:H)].each do |card|
      p.hand.send(:<<, card)
    end
    p.hand.send(:flatten!)
    
    all_combos = p.send(:all_possible_sums_of_points)
    assert_equal [1,2,3,4,5,6], all_combos
  end
  
  def test_a_player_can_use_ace_as_one_or_fourteen
    p = Player.new(:ian)
    [Card.new("A",:H), Card.new(2,:H)].each do |card|
      p.hand.send(:<<, card)
    end
    p.hand.send(:flatten!)
    
    all_combos = p.send(:all_possible_sums_of_points)
    assert_equal [1,2,3,14,16], all_combos
  end
  
end