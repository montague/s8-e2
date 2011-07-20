# A game gets created by passing it a list of players
module SellKnives
  class Game
    attr_reader :players, :draw_pile, :spent_pile, :roads, :cost_to_claim_a_road

    def initialize(players)
      @players = players
      @players.each do |player|
        player.game = self
      end
      shuffle_cards
      @spent_pile = []
      @cost_to_claim_a_road = [*8..13].sample
      @roads = {}
      [*1..@cost_to_claim_a_road].combination(2).each do |a,b|
        @roads[[a,b]] = nil # no road has been claimed yet
      end
    end

    def shuffle_cards
      @draw_pile = Deck.new.cards
    end

    def claimed_roads_count
      @roads.values.select {|claim| claim }.count
    end
    
    def over?
      @roads.count == claimed_roads_count
    end

    def and_the_winner_is
      if over?
        return @players.max{|a,b| a.claimed_roads.count <=> b.claimed_roads.count}
      end
      
      nil
    end
  end
end