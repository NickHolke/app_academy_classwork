def factors(num)
  result = [1]
  (2..num / 2).each do |x|
    result << x if num % x == 0
  end
  result << num
  result
end

# p factors(360)

def inner_loop(arr)
  (0...arr.length - 1).each do |i|
    arr[i], arr[i + 1] = arr[i + 1], arr[i] if arr[i] > arr[i + 1]
  end
end


def bubble_sort(input)
  arr = input.clone
  sorted = false
  until sorted
    sorted = true
    (0...arr.length - 1).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
  end
  arr
end

# p bubble_sort([1, 5, 2, 7, 3, 8, 4, 9, 12])

def substrings(str)
  result = []
  (0...str.length).each do |i|
    (i...str.length).each do |j|
      result << str[i..j]
    end
  end
  result
end

require 'set'

# p substrings("cat")
def subwords(str)
  result = []
  dictionary = []
  strings = substrings(str)
  File.foreach('dictionary.txt') do |line|
    dictionary << line.chomp
  end
  dictionary = dictionary.to_set
  strings.each do |string|
    if dictionary.include?(string)
      result << string
    end
  end
  result
end

p subwords("cat")
