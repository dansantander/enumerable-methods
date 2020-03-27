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

  describe '#my_all?' do
    it 'returns false unless all the elements of a collection comply with a block argument' do
      expect(array.my_all?{ |x| x > 5}).to eql(false)
    end

    it 'returns false unless all the elements of a collection are equal to the passed argument' do
      expect([1, 2, 4, 'hello'].my_all?(2)).to eql(false)
    end

    it 'returns false unless all the elements of a collection belong to the same Class' do
      expect([1, 2, 4, 'hello'].my_all?(Integer)).to eql(false)
    end

    it 'returns false unless all the elements of a collection match a Regex argument' do
      expect(['cat', 'bat', 'cup'].my_all?(/t/)).to eql(false)
    end

    it 'returns false unless all the elements of a collection are true' do
      expect([true, true, false].my_all?).to eql(false)
    end

    it 'returns true if all the elements of a collection comply with the given argument' do
      expect([2,4,6,8].my_all?(&:even?)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if at least one of the elements of a collection comply with a block argument' do
      expect(array.my_any?{ |x| x > 5}).to eql(true)
    end

    it 'returns true if at least one of the elements of a collection are equal to the passed argument' do
      expect([1, 2, 4, 'hello'].my_any?(2)).to eql(true)
    end

    it 'returns true if at least one of the elements of a collection belong to the same Class' do
      expect([1, 2, 4, 'hello'].my_any?(Integer)).to eql(true)
    end

    it 'returns true if at least one of the elements of a collection match a Regex argument' do
      expect(['cat', 'bat', 'cup'].my_any?(/t/)).to eql(true)
    end

    it 'returns true if at least one of the elements of a collection are true' do
      expect([true, true, false].my_any?).to eql(true)
    end

    it 'returns false if none of the elements of a collection comply with the given argument' do
      expect([1,3,5,7].my_any?(&:even?)).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns false if any of the elements of a collection comply with a block argument' do
      expect(array.my_none?{ |x| x > 5}).to eql(false)
    end

    it 'returns false if any of the elements of a collection are equal to the passed argument' do
      expect([1, 2, 4, 'hello'].my_none?(2)).to eql(false)
    end

    it 'returns false if any of the elements of a collection belong to the same Class' do
      expect([1, 2, 4, 'hello'].my_none?(Integer)).to eql(false)
    end

    it 'returns false if any of the elements of a collection match a Regex argument' do
      expect(['cat', 'bat', 'cup'].my_none?(/t/)).to eql(false)
    end

    it 'returns false if any of the elements of a collection are true' do
      expect([true, true, false].my_none?).to eql(false)
    end

    it 'returns true if none the elements of a collection comply with the given argument' do
      expect([1,3,5,7].my_none?(&:even?)).to eql(true)
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

  describe '#my_inject' do
    it 's' do
    
    end
  end

end
