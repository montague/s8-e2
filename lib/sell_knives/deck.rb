module SellKnives
  class Deck
    def self.randomized
      cards = []
      %w{A 2 3 4 5 6 7 8 9 10 J Q K}.each do |value|
        %W{C S D H}.each do |suit|
          cards << Card.new(value,suit)
        end
      end
      cards.shuffle
    end
  end
end
