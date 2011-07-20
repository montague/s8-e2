module SellKnives
  class Player
    attr_reader :name, :hand, :claimed_roads, :game

    def initialize(name)
      @name = name
      @hand = []
      @claimed_roads = []
    end

    def game=(game)
      @game = game unless @game
    end
    
    def draw_card
      @game.shuffle_cards if @game.draw_pile.empty?
      @hand << @game.draw_pile.shift
    end
    
    def spend_card(card)
      @hand.delete card
      @game.spent_pile << card
    end

    def show_hand
      @hand.map{ |card| card.to_display}.join(',')
    end

    def claim_roads number_to_claim
      return false if number_to_claim < 1
      
      sums = all_possible_sums_of_points
      points_required = number_to_claim * @game.cost_to_claim_a_road
      
      if sums.value? points_required
        number_to_claim.times do
          road_to_claim = @game.roads.keys.select{ |road| @game.roads[road].nil? }.first
          @claimed_roads << road_to_claim
          @game.roads[road_to_claim] = self
        end
        # these babies are spent boyeeeee
        sums.key(points_required).each do |card|
          spend_card(card)
        end
        return true
      end

      false
    end

    private
    # 
    # def can_claim? number_to_claim
    #   all_possible_sums_of_points.value?(number_to_claim * @game.cost_to_claim_a_road)
    # end


    def all_possible_sums_of_points
      sums = {}
      (1..@hand.count).each do |c|
        @hand.combination(c).each do |combo|
          sums[combo] = combo.inject(0) {|memo,card| memo + card.value}
        end
      end
      sums
      # values = @hand.map{ |card| card.value }
      #       sums = all_possible_sums_of values
      # 
      # if @hand.any? {|card| card.ace? } # take care of any aces
      #   values = @hand.map{ |card| card.value == 1 ? 14 : card.value }
      #   sums += all_possible_sums_of values
      # end
      # sums.uniq.sort
    end

    # def all_possible_sums_of values
    #   sums = []
    #   (1..values.count).each do |c|
    #     values.combination(c).each do |combo|
    #       sums << combo.inject(:+)
    #     end
    #   end
    #   sums
    # end

  end
end