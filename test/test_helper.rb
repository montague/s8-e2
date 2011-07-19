Dir.chdir File.expand_path('../..', __FILE__) #for textmate's cmd+R
require_relative '../lib/sell_knives'
require 'test/unit'
class Test::Unit::TestCase
  include SellKnives
end

def create_two_players
  [Player.new(:ian), Player.new(:adrien)]
end