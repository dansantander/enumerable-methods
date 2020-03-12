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

  # MY ALL
  def my_all?(args = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }

    elsif args.class == Class
      my_each { |i| return false unless i.is_a? arg s }

    elsif args.class == Regexp
      my_each { |i| return false unless i.match? args }

    elsif my_each { |i| return false unless i == args }
    else my_each { |i| return false unless i }
    end
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
