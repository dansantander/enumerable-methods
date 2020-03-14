module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = is_a?(Range) ? to_a : self
    i = 0
    until i == arr.length
      yield(arr[i])
      i += 1
    end
    arr
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = is_a?(Range) ? to_a : self
    i = 0
    until i == arr.length
      yield(arr[i], i)
      i += 1
    end
    arr
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      arr << i if yield(i)
    end
    arr
  end

  def my_all?(args = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }

    elsif args.class == Class
      my_each { |i| return false unless i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return false unless i.match? args }

    elsif !args.nil?
      my_each { |i| return false unless i == args }
    else my_each { |i| return false unless i }
    end
    true
  end

  def my_any?(args = nil)
    if block_given?
      my_each { |i| return true if yield(i) }

    elsif args.class == Class
      my_each { |i| return true if i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return true if i.match? args }

    elsif !args.nil?
      my_each { |i| return true if i == args }
    else my_each { |i| return true if i }
    end
    false
  end

  def my_none?(args = nil)
    if block_given?
      my_each { |i| return false if yield(i) }

    elsif args.class == Class
      my_each { |i| return false if i.is_a? args }

    elsif args.class == Regexp
      my_each { |i| return false if i.match? args }

    elsif !args.nil?
      my_each { |i| return false if i == args }
    else my_each { |i| return false if i }
    end
    true
  end

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

  def my_map(my_proc = nil)
    return to_enum unless block_given? || my_proc

    arr = []
    my_each do |i|
      arr << if my_proc
               my_proc.call(i)
             else
               yield(i)
             end
    end
    arr
  end

  def my_inject(initial = nil, sym = nil)
    arr = is_a?(Array) ? self : to_a
    if block_given?
      res = initial
      if initial.nil?
        res = arr[0]
        arr = arr[1..-1]
      end
      arr.my_each { |x| res = yield(res, x) }
      res
    elsif initial.class == Symbol
      res = arr[0]
      arr[1..-1].my_each { |x| res = res.send(initial, x) }
      res
    elsif sym.class == Symbol
      res = initial
      arr.my_each { |x| res = res.send(sym, x) }
      res
    end
  end
end

def multiply_els(array)
  array.my_inject do |num, n|
    num * n
  end
end
