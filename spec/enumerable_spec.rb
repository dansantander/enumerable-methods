require_relative '../methods.rb'

describe Enumerable do
  let (:array) { [2,4,78,9,3] }
  let (:range) { (1..5) }

  describe '#my_each' do
    it 'returns an enumerator if no block given' do
      expect(array.my_each).to be_a(Enumerable)
    end

    it 'returns original array if any block given' do
      expect(array.my_each { |x| x }).to eql(array)
    end

    it 'returns an array if a range is given' do
      expect(range.my_each { |x| x }).to eql(range.to_a)
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerator if no block given' do
      expect(array.my_each_with_index).to be_a(Enumerable)
    end

    it 'returns original array if any block given' do
      expect(array.my_each_with_index{ |x| x }).to eql(array)
    end

    it 'returns an array if a range is given' do
      expect(range.my_each_with_index { |x| x }).to eql(range.to_a)
    end

    it 'returns index and items if any block given' do
      ans = []
      array.my_each_with_index { |v, i| ans << "#{i}: #{v}" }
      expect(ans).to eql(['0: 2', '1: 4', '2: 78', '3: 9', '4: 3'])
    end
  end

  describe '#my_select' do
    it 'returns an enumerator if no block given' do
      expect(array.my_select).to be_a(Enumerable)
    end

    it 'returns an empty array when called on an emtpy array' do
      ans = []
      expect(ans.my_select{ |x| x}).to eql([])
    end

    it 'returns an array with elements that comply with a given condition' do
      ans = array.my_select(&:even?)
      expect(ans).to eql([2, 4, 78])
    end
  end

  describe '#my_count' do
    it 'returns the number of elements in an array' do
      expect(array.my_count).to eql(5)
    end

    it "returns the number of ocurrences of the passed argument in a given array" do
      expect(array.my_count(2)).to eql(1)
    end

    it 'returns the number of elements that comply with a block given condition' do
      expect(array.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
  ans = []
  let(:my_proc) { proc { |elem| elem * 2 } }

    it 'returns an enumerator if no block or proc given ' do
      expect(array.my_map).to be_a(Enumerable)
    end

    it 'returns a new array containing the results of calling a given proc' do
      expect(array.my_map(my_proc)).to eql([4, 8, 156, 18, 6])
    end

    it 'returns a new array containing the results of a given block' do
      expect(array.my_map{ |x| x * 2 }).to eql([4, 8, 156, 18, 6])
    end
  end

end
