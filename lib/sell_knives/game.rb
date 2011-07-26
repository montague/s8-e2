# A game gets created by passing it a list of players
module SellKnives
  class Game
    attr_reader :players, :draw_pile, :spent_pile, :roads, :cost_to_claim_a_road

    def initialize(players)
      setup_players players
      
      @spent_pile = []
      
      shuffle_cards
      
      setup_roads
    end

    def shuffle_cards
      @draw_pile = Deck.randomized
    end

    def claimed_roads_count
      @roads.values.select {|claim| claim }.count
    end
    
    def over?
      @roads.count == claimed_roads_count
    end

    def winner
      raise "not over yet!" unless over? 
      @players.max_by {|player| player.claimed_roads.count}
    end
    
    private
    def setup_players(players)
      @players = players  
      @players.each do |player|
        player.game = self
      end
    end
    
    def setup_roads
      @roads                = {}
      @cost_to_claim_a_road = [*8..13].sample
      
      [*1..@cost_to_claim_a_road].combination(2).each do |a,b|
        @roads[[a,b]] = nil # no road has been claimed yet
      end
    end
  end
end