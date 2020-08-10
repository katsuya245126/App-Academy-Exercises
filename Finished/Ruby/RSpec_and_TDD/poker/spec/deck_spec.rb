require 'rspec'
require 'deck'
# rubocop:disable all

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "creates 52 unique cards inside an array" do
      expect(deck.cards.size).to eq(52)
      expect(deck.cards.uniq.size).to eq(52)
    end
  end

  describe "#take_card" do
    it "takes a card from the deck and returns it" do
      expect(deck.take_card.is_a?(Card)).to eq true
      expect(deck.cards.size).to eq(51)
    end
  end

  describe "#return_card" do
    let(:taken_card) { deck.take_card }

    context "when receiving a duplicate card" do
      let(:duplicate) { deck.cards.sample }

      it "raises an error" do
        expect { deck.return_card(duplicate) }.to raise_error("That card is already in the deck")
      end
    end
    
    it "returns the card to the bottom of the deck" do
      deck.return_card(taken_card)
      expect(deck.cards[0]).to eq(taken_card)
    end
  end
end
