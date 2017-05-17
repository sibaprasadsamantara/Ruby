def flatten_array_elements(array:, flatten_array: [])
  array.each do |ele|
    if ele.kind_of?(Array)
      flatten_array_elements(array: ele, flatten_array: flatten_array)
    else
      flatten_array << ele
    end
  end
  flatten_array 
end

p flatten_array_elements(array: [1,[2,3,4], [[4,5,6]]])
p flatten_array_elements(array: [1,2,3,4,5])
