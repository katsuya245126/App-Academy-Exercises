require 'rspec'
require 'poker'
require 'player'
# rubocop:disable all

describe Poker do
  let(:poker) { Poker.new }
  let(:hand_double) { double("hand") }

  describe "#initialize" do
    it "initializes empty pot" do
      expect(poker.pot).to eq(0)
    end

    it "initializes a deck" do
      expect(poker.deck).to_not eq(nil)
      expect(poker.deck.cards.size).to eq(52)
    end
  end

  describe "#add_player" do
    let!(:before) { poker.players.size }
    it "adds players to @players" do
      poker.add_player(Player.new)
      expect(poker.players.size).to eq(before + 1)
    end

    it "raises an error if there are 8 players already" do
      4.times { poker.add_player(Player.new) }
      expect { poker.add_player(Player.new) }.to raise_error('There are 8 players already')
    end
  end

  describe "#deal_cards" do
    it "gives all of the players 5 cards" do
      poker.deal_cards

      expect(
        poker.players.all? { |p| p.card_count == 5 }
      ).to be(true)
    end
  end

  describe "#game_over?" do
    it "returns true if all players except one has no money" do
      (0..2).each do |idx|
        poker.players[idx].bet(100_000)
      end
      
      expect(poker.game_over?).to be(true)
    end
  end
end
