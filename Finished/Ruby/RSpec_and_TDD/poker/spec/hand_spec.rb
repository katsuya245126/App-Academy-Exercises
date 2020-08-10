require 'rspec'
require 'hand'
require 'card'
# rubocop:disable all

describe Hand do
  let(:full_house) {
    [
      Card.new(5, "h"),
      Card.new(5, "s"),
      Card.new(5, "c"),
      Card.new(13, "d"),
      Card.new(13, "h")
    ]
  }
  let(:empty_hand) { Hand.new }
  subject(:hand) { Hand.new(full_house) }

  describe "#initialize" do
    it "initiates hand with given parameter" do
      expect(hand.cards).to match_array(full_house)
    end

    it "initializes empty array if given no parameter" do
      expect(empty_hand.cards).to eq([])
    end

    it "raises an error if given array is too big" do
      expect { Hand.new([1,2,3,4,5,6]) }.to raise_error("Hand too big")
    end
  end

  describe "#add_card" do
    let(:five_h) { Card.new(5, "h") }

    it "only accepts cards" do
      expect { empty_hand.add_card(five_h) }.not_to raise_error
      expect { hand.add_card("wow") }.to raise_error("Not a card")
      expect { hand.add_card(123) }.to raise_error("Not a card")
    end

    it "takes in a card and adds it to the array" do
      empty_hand.add_card(five_h)
      expect(empty_hand.cards.size).to eq(1)
      expect(empty_hand.cards.last).to eq(five_h)
    end

    context "when hand is already full" do
      it "raises an error" do
        expect { hand.add_card(five_h) }.to raise_error("Hand is full")
      end
    end
  end

  describe "#discard_card" do
    context "when given cards that exist in hand" do
      it "removes the cards from the hand" do
        hand.discard_card(["5h", "Kd"])
        expect(hand.cards.select { |card| card.to_s == "5h" }).to eq([])
        expect(hand.cards.select { |card| card.to_s == "Kd" }).to eq([])
      end

      it "returns the removed cards" do
        expect(hand.discard_card(["Kd", "5h"])).to match_array([Card.new(13, "d"), Card.new(5, "h")])
      end
    end

    context "when given cards that are not in hand" do
      it "raises an error" do
        expect { hand.discard_card(["3h"]) }.to raise_error("Card not in hand")
      end
    end
  end

  describe "#hand_strength" do
    let(:straight_flush) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(6, "h"),
        Card.new(7, "h"),
        Card.new(8, "h"),
        Card.new(9, "h")
      ])
    }

    let(:four_kind) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(5, "s"),
        Card.new(5, "c"),
        Card.new(5, "d"),
        Card.new(9, "h")
      ])
    }

    let(:flush) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(7, "h"),
        Card.new(9, "h"),
        Card.new(11, "h"),
        Card.new(13, "h")
      ])
    }

    let(:straight) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(6, "s"),
        Card.new(7, "c"),
        Card.new(8, "d"),
        Card.new(9, "h")
      ])
    }

    let(:three_kind) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(5, "s"),
        Card.new(5, "c"),
        Card.new(8, "d"),
        Card.new(9, "h")
      ])
    }

    let(:two_pair) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(5, "s"),
        Card.new(6, "c"),
        Card.new(6, "d"),
        Card.new(9, "h")
      ])
    }

    let(:one_pair) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(5, "s"),
        Card.new(6, "c"),
        Card.new(11, "d"),
        Card.new(9, "h")
      ])
    }

    let(:high_card) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(7, "s"),
        Card.new(9, "c"),
        Card.new(11, "d"),
        Card.new(13, "h")
      ])
    }

    it "returns the correct hand strength for each hand" do
      expect(straight_flush.hand_strength).to eq(9)
      expect(four_kind.hand_strength).to eq(8)
      expect(hand.hand_strength).to eq(7)
      expect(flush.hand_strength).to eq(6)
      expect(straight.hand_strength).to eq(5)
      expect(three_kind.hand_strength).to eq(4)
      expect(two_pair.hand_strength).to eq(3)
      expect(one_pair.hand_strength).to eq(2)
      expect(high_card.hand_strength).to eq(1)
    end

    let(:higher_flush) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(7, "h"),
        Card.new(9, "h"),
        Card.new(12, "h"),
        Card.new(13, "h")
      ])
    }

    let(:lower_two_pair) {
      Hand.new([
        Card.new(4, "h"),
        Card.new(4, "s"),
        Card.new(6, "c"),
        Card.new(6, "d"),
        Card.new(9, "h")
      ])
    }

    let(:higher_full_house) {
      Hand.new([
        Card.new(5, "h"),
        Card.new(5, "s"),
        Card.new(5, "c"),
        Card.new(14, "d"),
        Card.new(14, "h")
      ])
    }

    let(:lower_four_kind) {
      Hand.new([
        Card.new(4, "h"),
        Card.new(4, "s"),
        Card.new(4, "c"),
        Card.new(4, "d"),
        Card.new(9, "h")
      ])
    }

    it "returns breaks the tie correctly" do
      expect(higher_flush <=> flush).to eq(1)
      expect(lower_two_pair <=> two_pair).to eq(-1)
      expect(higher_full_house <=> hand).to eq(1)
      expect(lower_four_kind <=> four_kind).to eq(-1)
    end
  end
end