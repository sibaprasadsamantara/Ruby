
def array_max_element(first=nil, given_array)
  first, *last = given_array
    last.each do |ele|
      if first > ele
        array_max_element(first, last-[ele])
      else
        first = ele
        last = last - [ele]
        array_max_element(first, last)
      end
    end
    first
end

puts array_max_element([0.1, 0.2, 0.0, 0.5, 1])

