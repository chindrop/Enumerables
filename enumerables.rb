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
  a = ['a', 'b', 'c']
  a.my_each {|x| puts x, "--"}
end
