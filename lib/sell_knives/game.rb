# A game gets created by passing it a list of players
module SellKnives
  class Game
    attr_reader :players, :draw_pile, :spent_pile, :roads, :number_of_roads

    def initialize(players)
      @players = players
      @draw_pile = Deck.new.cards
      @spent_pile = []
      @number_of_roads = [*8..13].sample
      @roads = {}
      [*1..@number_of_roads].combination(2).each do |a,b|
        @roads[[a,b]] = nil # no road has been claimed yet
      end
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