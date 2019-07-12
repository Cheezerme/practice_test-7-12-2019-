require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.
  #inject is .each like thing that intializes acc as whatever value is passed my_inject(acc) , and alsi tajes a block
  def my_inject(accumulator = nil, &block)
    if accumulator == nil
      accumulator = self[0]
    end
    self.each do |ele|
      accumulator = block.call(accumulator,ele)
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2..num).any?{|divisor| num % divisor == 0}
end

def primes(num)
  if num == 0 
    return []
  end
  count = 0 
  prime_array = []
  curr_num = 0
  until count == num
    if is_prime?(curr_num)
      prime_array += [curr_num]
      curr_num +=1
      count+=1
    end
      curr_num+=1
  end
  prime_array
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  fact_arr = []
  if num <= 1
    return 1
  else
    fact_arr << factorial(num-1)
    fact_arr << factorials_rec(num-1)
  end
  fact_arr
end
def factorial(num)
  if num == 0
    return 1
  else
    num * factorial(num-1)
  end
end
class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    dups_hash = Hash.new{|hash,k| hash[k] = []}
    self.each_with_index do |dups,idx|
      dups_hash[dups]<<idx
    end
    dups_hash.values.select{|val| val.size >1}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = self.substrings
    subs.select do |sub| 
      if sub==sub.reverse
      end
    end
  end

  def substrings(string)
    subs = []
    string.each_with_index do |str1,idx1|
      string.each_with_index do |str2,idx2|
        if idx1 < idx2 
          subs << string[idx1..idx2]
        end
      end
    end
    subs
  end

end
class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    if self.size == 0 
      return self
    end
    prc ||= Proc.new{|ele1,ele2| ele1 <=> ele2}
    left = self.take(self.length / 2)
    right = self.drop(self.length / 2)
    arr = Array.merge_sort(merge_sort(left),merge_sort(right),prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      case prc.call(left[0],right[0])
      when 1 
        merged << left.shift
      when 0 
        merged << left.shift
        merged < right.shift
      when -1
        merged << right.shift
      end
    end
  end
end
