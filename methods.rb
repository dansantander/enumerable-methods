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

  # MY MAP
  def my_map
    return to_enum unless block_given?

    i = 0
    arr = []
    until i == length
      arr << yield(self[i])
      i += 1
    end
    arr
  end
end

# TEST CASES
array = [8, 10, 23]

array.my_each do |x|
  puts x
end

res = array.my_map do |x|
  x * 2
end
puts res
