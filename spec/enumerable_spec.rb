require_relative '../methods.rb'

describe Enumerable do
  let (:array) { [2,4,78,9,3] }
  let (:range) { (1..5) }

  describe '#my_each' do
    it 'Returns an enumerator if no block given' do
      expect(array.my_each).to be_a(Enumerable)
    end

    it 'Returns original array if any block given' do
      expect(array.my_each { |x| x }).to eql(array)
    end

    it 'Returns an array if a range is given' do
      expect(range.my_each { |x| x }).to eql(range.to_a)
    end
  end

  describe '#my_each_with_index' do
  let (:xpected_arr) { [] }
    it 'Returns an enumerator if no block given' do
      expect(array.my_each_with_index).to be_a(Enumerable)
    end

    it 'Returns original array if any block given' do
      expect(array.my_each_with_index{ |x| x }).to eql(array)
    end

    it 'Returns an array if a range is given' do
      expect(range.my_each_with_index { |x| x }).to eql(range.to_a)
    end

    it 'Returns index and items if any block given' do
      expect(
        array.my_each_with_index { |v, i| puts "#{v}, #{i}" }
        ).to eql(array.each_with_index { |v, i| puts "#{v}, #{i}" })
    end

  end

end
