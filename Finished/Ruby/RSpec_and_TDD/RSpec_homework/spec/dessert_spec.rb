require 'rspec'
require 'dessert'
# rubocop:disable all

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! 
Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:dessert) { Dessert.new("cream puff", 100, chef) }
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cream puff")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cream puff", "abc", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("flour")

      expect(dessert.ingredients).to include("flour")
    end
  end

  describe "#mix!" do
    ingredients = ["A", "B", "C", "D", "E"]
    before(:each) do
      ingredients.each { |ing| dessert.add_ingredient(ing) }
    end

    it "shuffles the ingredient array" do
      expect(dessert.mix!).to_not eq(ingredients)
    end
  end

  describe "#eat" do
    let!(:original) { dessert.quantity }

    it "subtracts an amount from the quantity" do
      dessert.eat(10)
      expect(dessert.quantity).to eq(original - 10)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(110) }.to raise_error(StandardError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef John the Great Baker")
      expect(dessert.serve).to eq("Chef John the Great Baker has made 100 cream puffs!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
