module SellKnives
  class Player
    attr_reader :name, :hand, :claimed_roads

    def initialize(name)
      @name = name
      @hand = []
      @claimed_roads = []
    end


    def draw_from cards
      @hand << cards.shift
    end

    def claim_road roads, number_of_roads_to_claim, points_required_to_claim_a_road
      if can_claim? number_of_roads_to_claim, points_required_to_claim_a_road  
        number_of_roads_to_claim.times do
          road_to_claim = roads.keys.select{ |road| roads[road].nil? }.first
          @claimed_roads << road_to_claim
          roads[road_to_claim] = self
        end

        return true
      end

      false
    end

    private

    def can_claim? number_of_roads_to_claim, points_required_to_claim_a_road
      all_possible_sums_of_points.include?(number_of_roads_to_claim * points_required_to_claim_a_road)
    end


    def all_possible_sums_of_points

      values = @hand.map{ |card| card.value }
      sums = all_possible_sums_of values

      if @hand.any? {|card| card.ace? } # take care of any aces
        values = @hand.map{ |card| card.value == 1 ? 14 : card.value }
        sums += all_possible_sums_of values
      end
      sums.uniq.sort
    end

    def all_possible_sums_of values
      sums = []
      (1..values.count).each do |c|
        values.combination(c).each do |combo|
          sums << combo.inject(:+)
        end
      end
      sums
    end

  end
end