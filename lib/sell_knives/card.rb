module SellKnives
  class Card
    attr_reader :value,:suit,:display_value
    def initialize(value,suit)
      set_values value
      @suit = suit
    end
    
    def ace?
      @display_value == "A"
    end
    
    private
    def set_values value
      @display_value = value
      case value
      when "A"
        @value = 1
      when "K"
        @value = 13
      when "Q"
        @value = 12
      when "J"
        @value = 11
      else
        @value = value
      end
    end
  end
end