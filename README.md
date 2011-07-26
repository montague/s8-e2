# Sell Knives for Cut Stuff Co

## Background

- You are a poor liberal arts major who has just graduated from college. You can't get a job, so as a last resort you attend one of those group interviews for Cut Stuff Co®, purveyor of fine slicing and dicing instruments. Congratulations! You (and everyone else you interviewed with) was offered a job! You start tomorrow.

The Sales Route:

- It turns out that Cut Stuff Co® knives are wildly popular. So popular, in fact, that you can't walk down a single street without selling out of your knives completely. To solve this problem, CSC has set up knife distribution centers around town. Therefore, the only way you can sell these knives is by stocking up at a distribution center, then walking down a street that leads directly to another distribution center. You stock up again, then walk down another road (at the end of which is yet another CSC distribution center...). These knives are so popular that the salesperson who sells the most each day is simply the one who walked down the most roads.

Ownership of routes:

- Given the highly competitive nature of sales people (and the fact that you are all armed to the teeth with CSC knives), a system of street ownership has been developed--only one salesperson gets to walk down a particular street. Before you all set out for the day, you play a little game to determine who gets to walk down which road.

Pieces required:

- Standard deck of cards (no jokers except for the players... heh)  
- Paper and a different colored marker for each player.  

Set up:

- Each player draws a card until someone has picked a card that is greater than 7. This is the number of knife centers in the game. For example, assume the card chosen was a Queen (12). There are 12 knife centers. We'll call this number KCOUNT.

- Each knife distribution center (KDC) is drawn as a circle on the piece of paper. Initially, there are no claimed roads and therefore, no connections between the KDCs.  - The cards chosen are returned to the deck. 

- The deck becomes the draw pile. Spent cards are placed in a discard pile. If the draw pile ever becomes empty, the discard pile is shuffled and becomes the new draw pile.

Game play:

- The goal of the game is to claim as many roads as possible. The game ends when every possible road between each KDC has been claimed by a CSC salesperson. 
- Each turn, a player can do one of two things:  

  - draw a card  
  
  - claim one or more roads

- Each card drawn adds that many points to a player's road stash.  

- To claim a road, the player needs to spend exactly KCOUNT points (or a multiple of KCOUNT to claim more than one road). For our example, drawing a Q allows the player to immediately claim ownership of a road on his next turn. After claiming the road, the card is placed in the discard pile. The player can then take his marker and draw his road on the map.

- Aces can count as either 1 or 14 points.

Strategy:  

- You can either be greedy and claim roads as soon as you are able, or you can hold out for large road acquisitions by saving up to claim multiple roads at once. The trade off is that you may never have a hand of cards worth exactly 48 points to claim four roads at once. Wait too long, and your opponent(s) might have sliced and diced up the road map so that there aren't many roads left.

Examples:  

- KCOUNT is 12. The only viable claims must be made with cards (or combinations of cards) totaling multiples of 12.  

- K 10 4 -- You can't do anything because no combination of cards adds up to a multiple of 12. 

- Q A 6 4 -- Lots of possibilities. Spend the Q and claim one road. Spend A (as 14) , 6, 4 and claim 2 roads (24 points). Or , spend everything and claim 3 roads.


## Game Engine

To begin using the game engine, create some players.
    
    jacques = Player.new :"Jacques Cousteau"
    mike    = Player.new :"Mike Meyers"

Next, create a game for those players and have each player draw a card to start.

    the_game = Game.new [jacques, mike]
    jacques.draw_card
    mike.draw_card

The game has started and the race is on! For an in-code example of how the game engine can be used, take a look at (and run) `examples/sell_some_freaking_knives`.