# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality, Metrics/MethodLength
module Enumerable
  def my_each
    if block_given?
      size.times do |elem|
        yield(to_a[elem])
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      length.times do |index|
        yield self[index], index
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    result = []
    if block_given?
      my_each do |element|
        result << element if yield element
      end
      result
    else
      to_enum(:my_select)
    end
  end

  def my_all?(arg = nil)
    my_each do |element|
      if block_given?
        return false unless yield element
      elsif arg.nil?
        return false unless element
      else
        return false unless arg === element
      end
    end
    true
  end

  def my_any?(arg = nil)
    my_each do |element|
      if block_given?
        return true if yield element
      elsif arg.nil?
        return true if element
      elsif arg === element
        return true
      end
    end
    false
  end

  def my_none?(arg = nil)
    my_each do |element|
      if block_given?
        return false if yield element
      elsif arg.nil?
        return false if element
      elsif arg === element
        return false
      end
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if !arg.nil?
      my_each do |element|
        count += 1 if element == arg
      end
    elsif block_given?
      my_each do |element|
        count += 1 if yield element
      end
    else
      my_each do
        count += 1
      end
    end
    count
  end

  def my_map(&block)
    result = []
    return to_enum(:my_map) unless block_given?

    my_each do |element|
      if block_given?
        result.push(yield element)
      else
        result.push(block.call(element))
      end
    end
    result
  end

  def my_inject(*args)
    new_array = is_a?(Array) ? self : to_a

    if args[0].is_a?(Symbol) || args[0].is_a?(String)
      sym = args[0]
    elsif args[0].is_a?(Integer)
      memo = args[0]
      sym = args[1] if args[1].is_a?(Symbol) || args[1].is_a?(String)
    end
    if sym
      new_array.my_each do |item|
        memo = if memo
                 memo.send(sym, item)
               else
                 item
               end
      end
    else
      new_array.my_each do |item|
        memo = if memo
                 yield(memo, item)
               else
                 item
               end
      end
    end
    memo
  end
end
def multiply_els(array)
  array.my_inject(:*)
end
# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/CaseEquality, Metrics/MethodLength

[1, 2, 3, 4, 5].my_each_with_index { |element, index| puts "#{element} => #{index}" }