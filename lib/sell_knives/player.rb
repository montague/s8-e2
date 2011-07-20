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
      
      able_to_claim = claim_points sums, points_required
      
      if able_to_claim
        number_to_claim.times do
          road_to_claim = @game.roads.keys.select{ |road| @game.roads[road].nil? }.first
          @claimed_roads << road_to_claim
          @game.roads[road_to_claim] = self
        end

        # these babies are spent boyeeeee
        sums.key(able_to_claim).each do |card|
          spend_card(card)
        end
        return true
      end

      false
    end

    private
    
    
    def claim_points sums, points_required
      sums.each do |combo,value|
        return value if value.respond_to?(:include?) && value.include?(points_required)
        return value if value == points_required
      end
      nil
    end


    def all_possible_sums_of_points
      sums = {}
      (1..@hand.count).each do |c|
        @hand.combination(c).each do |combo|
          if combo.any?{|card| card.display_value == "A"}
            sums[combo] = [
                combo.inject(0) {|memo,card| memo + card.value},
                combo.inject(0) {|memo,card| memo + (card.value == 1 ? 14 : card.value)}
              ]
          else
            sums[combo] = combo.inject(0) {|memo,card| memo + card.value}
          end
        end
      end
      sums
    end
  end
end