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

  # MY ALL
  def my_all?(args = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }

    elsif args.class == Class
      my_each { |i| return false unless i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return false unless i.match? args }

    elsif my_each { |i| return false unless i == args }
    else my_each { |i| return false unless i }
    end
    true
  end

  # MY ANY
  def my_any?(args = nil)
    if block_given?
      my_each { |i| return true if yield(i) }

    elsif args.class == Class
      my_each { |i| return true if i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return true if i.match? args }

    elsif my_each { |i| return true if i == args }
    else my_each { |i| return true if i }
    end
    false
  end

  # MY NONE
  def my_none?(args = nil)
    if block_given?
      my_each { |i| return false if yield(i) }

    elsif args.class == Class
      my_each { |i| return false if i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return false if i.match? args }

    elsif my_each { |i| return false if i == args }
    else my_each { |i| return false if i }
    end
    true
  end

  # MY COUNT
  def my_count(args = nil)
    count = 0

    if block_given?
      my_each do |i|
        count += 1 if yield(i)
      end

    elsif !args.nil?
      my_each do |i|
        count += 1 if args == i
      end

    else
      count = length
    end
    count
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

puts 'my_count method:'
res = array.my_count do |x|
  x < 10
end
puts res

res2 = array.my_count(12)
puts res2

res3 = array.my_count
puts res3

puts 'my_all? method:'
puts "#{[18, 22, 33, 3, 5, '6'].my_all?(Numeric)}"
puts "#{%w[ cat bat cup ].my_all?(/t/)}"
puts "#{[18, 22, 33, 3, 5].my_all? {|num| num > 2}}"
puts "#{[true, true, false].my_all?}"
puts "#{[].my_all?}"
puts "#{[3, 3, 3].my_all?(3)}"

puts 'my_any? method:'
puts "#{[18, 22, 33, 3, 5, '6'].my_any?(Numeric)}"
puts "#{%w[ cat bat cup ].my_any?(/t/)}"
puts "#{[18, 22, 33, 3, 5].my_any? {|num| num > 2}}"
puts "#{[true, true, false].my_any?}"
puts "#{[].my_any?}"
puts "#{[3, 3, 3].my_any?(3)}"

puts 'my_none? method:'
puts "#{%w{ant bear cat}.my_none? { |word| word.length >= 4 }}"
puts "#{%w{ant bear cat}.my_none?(/d/)}"
puts "#{[1, 3.14, 42].my_none?(Float)}"
puts "#{[nil, false].my_none? }"
puts "#{[1, 2 , 3].my_none?}"
puts "#{[].my_none?}"