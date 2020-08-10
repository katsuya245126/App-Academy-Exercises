require_relative 'deck'
require_relative 'player'

class Poker
  attr_reader :pot, :deck, :players, :current_player, :min_bet, :current_bet

  def initialize(num = 4)
    @pot = 0
    @deck = Deck.new
    @players = []
    num.times { add_player(Player.new) }
    @current_player = players[0]
    @min_bet = 1000
    @current_bet = min_bet
  end

  def play
    clear_screen
  end

  def play_turn
    deal_cards
  end

  def bet_phase
    choice = current_player.prompt_turn
    case choice
    when :call then nil
    when :raise then nil
    when :fold then nil
    end
  end

  def raise
    amount = nil
    until valid_amount?(amount)
      print 'Raise by: '
      amount = gets.chomp.to_i
    end
    current_player.bet(amount)
  end

  def discard_phase
    discarded = current_player.prompt_discard
    discarded.length.times { current_player.receive_card(deck.take_card) }
    discarded.each { |card| deck.return_card(card) }
    clear_screen
    current_player.display_hand
    gets
  end

  def change_turn
    current_idx = players.find_index(current_player)
    next_idx = (current_idx + 1) % players.size
    @current_player = players[next_idx]
  end

  def add_player(player)
    raise 'There are 8 players already' if players.count >= 8

    players << player
  end

  def deal_cards
    deck.shuffle

    players.each do |player|
      until player.card_count >= 5
        card = deck.take_card
        player.receive_card(card)
      end
    end
  end

  def game_over?
    players.one? { |player| player.pot.positive? }
  end

  def clear_screen
    system('clear')
  end

  def valid_amount?(amount)
    return false unless amount.is_a?(Integer) && !amount.zero?
  end
end
