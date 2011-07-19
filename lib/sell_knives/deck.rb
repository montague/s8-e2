module SellKnives
  class Deck
    attr_reader :cards
    def initialize
      @cards = []
      %w{A 2 3 4 5 6 7 8 9 10 J Q K}.each do |value|
        %W{C S D H}.each do |suit| #for this game, suits don't matter. this does make debugging easier, though
          @cards << Card.new(value,suit)
        end
      end
      @cards.shuffle!
    end  
  end
end
