require 'rspec'
require 'card'
# rubocop:disable all

describe Card do
  let(:five_h) { Card.new(5, "h") }
  let(:king_c) { Card.new(13, "c") }
  let(:ace_s) { Card.new(14, "s") }

  describe "#initialize" do
    context "when given valid value and suit" do
      it "assigns value and suit" do
        expect(ace_s.value).to eq(14)
        expect(ace_s.suit).to eq("s")
      end
    end

    context "when given invalid value or suit" do
      it "raises an error" do
        expect { Card.new(0, "h") }.to raise_error("Invalid value and/or suit")
        expect { Card.new(5, "hey") }.to raise_error("Invalid value and/or suit")
      end
    end
  end

  describe "#to_s" do
    context "when the value is a facecard" do
      it "returns the correct letter" do
        expect(king_c.to_s).to eq("Kc")
        expect(ace_s.to_s).to eq("As")
      end
    end

    context "when the value is not a facecard" do
      it "returns the correct value" do
        expect(five_h.to_s).to eq("5h")
      end
    end
  end
end