FULL_PERCENTAGE = 100
ZERO = 0
ONE = 1

def distribute_array_items_by_percentage_value(given_array:, distribution_list:)
	sum = validate_distribution_list_percentage(distribution_list: distribution_list)
	if sum > FULL_PERCENTAGE || sum < FULL_PERCENTAGE
		raise "Sum of distribution list percentage should be 100"
	else
		each_element_percentage = FULL_PERCENTAGE/given_array.length
		result = nil
		distribution_list.each do |dl|
			number_of_elements = dl/each_element_percentage
	    result ||= []	
	    result << given_array[ZERO..number_of_elements - ONE]
	    given_array = given_array - given_array[ZERO..number_of_elements - ONE]
		end
		result
	end  
end

def validate_distribution_list_percentage(distribution_list:)
  distribution_list.inject(:+) 
end

p distribute_array_items_by_percentage_value(given_array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], distribution_list: [20, 40, 20, 20])

