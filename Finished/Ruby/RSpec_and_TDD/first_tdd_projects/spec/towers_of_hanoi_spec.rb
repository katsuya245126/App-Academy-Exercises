require 'towers_of_hanoi'
require 'rspec'
# rubocop:disable all

describe TowersOfHanoi do
  let(:game) { TowersOfHanoi.new }

  let(:finished_game) {
    game.make_move([0, 2])
    game.make_move([0, 1])
    game.make_move([2, 1])
    game.make_move([0, 2])
    game.make_move([1, 0])
    game.make_move([1, 2])
    game.make_move([0, 2])
    game
  }

  let(:unfinished_game) {
    game.make_move([0, 2])
    game.make_move([0, 1])
    game.make_move([2, 1])
    game
  }

  describe "#initialize" do
    it "initializes three arrays for rods" do
      expect(game.rods.all? { |rod| rod.is_a?(Array) }).to be true
    end

    it "adds three integers that represent discs inside the first array" do
      expect(game.rods[0]).to eq([3, 2, 1])
    end
  end

  describe "#make_move" do
    it "moves the disc to the correct location" do
      game.make_move([0, 2])
      expect(game.rods).to eq([[3, 2], [], [1]])
    end
  end

  describe "#won?" do
    context "when all discs are on the rightmost rod in the correct order" do
      it "returns true" do
        expect(finished_game.won?).to be true
      end
    end

    context "when not all discs are on the rightmost rod" do
      it "returns false"  do
        expect(unfinished_game.won?).to be false
      end
    end
  end
end