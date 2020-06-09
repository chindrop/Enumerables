# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      length.times do |elem|
        yield self[elem]
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      length.times do |elem|
        yield self[elem], index
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
  # rubocop:disable Style/CaseEquality

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
        return true unless yield element
      elsif arg.nil?
        return true unless element
      else
        return true unless arg === element
      end
    end
    false
  end

  def my_none?(arg = nil)
    my_each do |element|
      if block_given?
        return false unless yield element
      elsif arg.nil?
        return false unless element
      else
        return false unless arg === element
      end
    end
    false
  end
  # rubocop:enable Style/CaseEquality
end

fruits = ["apple", "banana", "strawberry", "pineapple"]

puts fruits.my_none? { |fruit| fruit.length > 10 }