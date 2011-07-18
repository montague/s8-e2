class Card
  attr_reader :value,:suit
  def initialize(value,suit)
    @value = value
    @suit = suit
  end
  
  def to_s
    "#{@value}#{@suit}"
  end
end