require 'rspec'
require 'player'
# rubocop:disable all

describe Player do
  let(:hand) { double("hand")}
  subject(:player) { Player.new(hand) }
  
  describe "#initialize" do
    it "gives the player starting pot of $100,000 unless stated otherwise" do
      expect(player.pot).to eq(100_000)
      expect(Player.new(hand, 200_000).pot).to eq(200_000)
    end

    it "initiates a hand with given cards" do
      expect(player.hand).to eq(hand)
    end

    it "initializes an empty hand if not given a hand" do
      expect(Player.new.hand.cards).to eq([])
    end
  end

  describe "#bet" do
    it "decreases the pot by the amount bet" do
      player.bet(1000)
      expect(player.pot).to eq(100_000 - 1000)
    end

    it "returns the bet amount" do
      expect(player.bet(1000)).to eq(1000)
    end
  end

  describe "#fold" do
    it "sets folded to true" do
      player.fold
      expect(player.folded?).to be(true)
    end
  end

  describe "#unfold" do
    it "sets folded to false" do
      player.unfold
      expect(player.folded?).to be(false)
    end
  end

  describe "#win_pot" do
    it "increases the player pot by the amount won" do
      player.win_pot(100_000)
      expect(player.pot).to eq(200_000)
    end
  end

  describe "#return_hand" do
    let!(:current_hand) { player.hand }

    it "returns the current hand" do
      expect(player.return_hand).to eq(current_hand)
    end

    it "sets the current hand to empty array" do
      player.return_hand
      expect(player.hand).to eq(nil)
    end
  end

  describe "#new_hand" do
    let!(:current_hand) { player.hand }
    let(:new_hand) { double("new_hand") }

    it "sets the new hand" do
      player.new_hand(new_hand)
      expect(player.hand).to eq(new_hand)
    end
  end
end