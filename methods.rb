module Enumerable
  # MY EACH
  def my_each
    return to_enum unless block_given?

    i = 0
    until i == length
      yield(self[i])
      i += 1
    end
    self
  end

  # MY EACH WITH INDEX
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    until i == length
      yield(self[i], i)
      i += 1
    end
    self
  end

  # MY SELECT
  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      arr << [i] if yield(i)
    end
    arr
  end

  # MY MAP
  def my_map
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      arr << yield(i)
    end
    arr
  end
end

# TEST CASES
array = [8, 10, 23]
puts "The original array is: array = #{array}"

puts 'my_each method:'
array.my_each do |x|
  puts x
end

puts 'my_each_with_index method:'
array.my_each_with_index do |x, y|
  puts "#{y}, #{x}"
end

puts 'my_map method:'
res = array.my_map do |x|
  x * 2
end
puts res

puts 'my_select method:'
res = array.my_select do |x|
  x < 10
end
puts res
