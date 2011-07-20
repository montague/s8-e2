require_relative 'test_helper'
class PlayerTest < Test::Unit::TestCase
  
  def test_all_possible_counts
    p = Player.new(:ian)
    c1,c2,c3 = Card.new(2,:H), Card.new(4,:H), Card.new(6,:H)
    [c1,c2,c3].each do |card|
      p.hand.send(:<<, card)
    end
    p.hand.send(:flatten!)
    
    all_combos = p.send(:all_possible_sums_of_points)
    expected = {
      [c1]       => 2, 
      [c2]       => 4, 
      [c3]       => 6, 
      [c1,c2]    => 6, 
      [c1,c3]    => 8, 
      [c2,c3]    => 10, 
      [c1,c2,c3] => 12
    }
    assert_equal expected, all_combos
  end

  def test_a_player_can_use_ace_as_one_or_fourteen
    p = Player.new(:ian)
    c1,c2 = Card.new("A",:H), Card.new(2,:H)
    [c1,c2].each do |card|
      p.hand.send(:<<, card)
    end
    p.hand.send(:flatten!)
    
    all_combos = p.send(:all_possible_sums_of_points)
    expected = {
      [c1] => [1,14],
      [c2] => 2,
      [c1,c2] => [3,16]
    }
    assert_equal expected, all_combos
  end
  
end