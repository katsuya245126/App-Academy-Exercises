require 'my_array_methods'
require 'rspec'
# rubocop:disable all

describe MyArrayMethods do
  subject(:array_methods) { MyArrayMethods.new }

  describe "#my_uniq" do
    let(:non_uniq) { [1, 2, 1, 3, 2, 4, 3, 4]}
    let(:uniq) { [1, 2, 3, 4] }

    it "accepts array as an argument" do
      expect { array_methods.my_uniq([1, 2, 3]) }.not_to raise_error
    end

    it "raises an error if not given an array" do
      expect { array_methods.my_uniq("1, 2, 3") }.to raise_error(ArgumentError)
    end

    it "returns a new array with no duplicate elements" do
      expect(array_methods.my_uniq(non_uniq)).to eq(uniq)
    end

    it "returns a new array with unique elements in the order they originally appear in" do
      uniqed = array_methods.my_uniq(non_uniq)
      original_order = uniqed.map { |i| non_uniq.find_index(i) }

      expect(original_order).to eq(original_order.sort)
    end
  end

  describe "#two_sum" do
    let(:array) { [-1, 0, 2, -2, 1] }
    let(:pairs) { [[0, 4], [2, 3]] }

    it "returns pairs of indexes where the sum is zero" do
      expect(array_methods.two_sum(array)).to eq(pairs)
    end

    it "returns pairs that are sorted by smaller index first" do
      paired = array_methods.two_sum(array)
      small_index_first = paired.all? { |a, b| a < b }

      expect(small_index_first).to be true
    end
  end

  describe "#my_transpose" do
    let(:original) { 
      [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    }

    let(:transposed) { 
      [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ]
    }

    it "accepts an array as argument" do
      expect { array_methods.my_transpose(original) }.not_to raise_error
    end

    it "raises an error if not given an array" do
      expect { array_methods.my_transpose("woohoo") }.to raise_error(ArgumentError)
      expect { array_methods.my_transpose(true) }.to raise_error(ArgumentError)
      expect { array_methods.my_transpose(69) }.to raise_error(ArgumentError)
    end

    it "turns rows into columns" do
      expect(array_methods.my_transpose(original)).to eq(transposed)
      expect(array_methods.my_transpose(transposed)).to eq(original)
    end
  end

  describe "#stock_picker" do
    let(:prices) { [2.5, 3.5, 1.2, 6.8, 4.2, 5.3] }
    let(:pair) { array_methods.stock_picker(prices) }

    it "accepts array of stock prices" do
      expect { array_methods.stock_picker(prices) }.not_to raise_error
    end

    it "raises an error if not given an array" do
      expect { array_methods.stock_picker("one two three") }.to raise_error(ArgumentError)
    end

    it "returns a pair of integers in an array" do
      expect(pair).to be_a(Array)
      expect(pair.all? { |i| i.is_a?(Numeric) }).to be(true)
    end

    it "buys before selling" do
      expect(pair[0]).to be < pair[1]
    end

    it "picks the most profitable days" do
      expect(pair).to eq([2,3])
    end
  end
end