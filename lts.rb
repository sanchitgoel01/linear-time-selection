# Partition an array into an array of arrays of size 5
# Runtime O(n)
def partition_by_5(arr)
  size = arr.size
  partition_size = size / 5.0
  partition_size.ceil()

  partitions = Array.new(partition_size)

  for i in (0...partition_size)
    start = 5 * i
    fin = (5 * (i + 1))
    fin = size if fin >= size

    partitions[i] = arr[start...fin]
  end

  return partitions
end

# Partition the array by the pivot value
# Return the position of the pivot value
# Runtime: O(n)
def partition_by_pivot(arr, pivot)
  lowpos = 0
  endpos = arr.size - 1

  arr.each do |el|
    if el != pivot
      if el > pivot
        arr[endpos] = el;
        endpos -= 1;
      else
        arr[lowpos] = el;
        lowpos += 1;
      end
    end
  end
  # Place pivot in correct position
  arr[lowpos] = pivot

  # Return position of the pivot
  return lowpos
end

# arr is an Array, k is the kth element to find
# Returns the value at the kth position. Positions start at 0.
# Runtime O(n).
def select(arr, k)
  size = arr.size

  if k >= arr.size
    raise "Selection position greater than array size!"
  end

  if size <= 5
    arr.sort! # Sort elements in place. O(1) since can't be more than 25 ops.
    return arr[k]
  end

  # Split the array into several arrays
  partitions = partition_by_5 arr
  # Return a new array that contains the medians of all the partitions
  medians = Array.new(partitions.size) { |i| select partitions[i], (partitions[i].size / 2) }

  # Find the pivot position. A.k.a the median of the medians of 5
  pivot = select(medians, medians.size / 2)

  # Partition the array in place and get the position of the pivot value
  pivot_pos = partition_by_pivot(arr, pivot)

  if pivot_pos == k
    return pivot
  elsif pivot_pos > k
    return select arr[0...pivot_pos], k 
  else
    return select arr[(pivot_pos + 1)..size], (k - pivot_pos)
  end

end

# Array of Numbers to Test
nums = [ -297, -293, -275, -274, -265, -241, -233, -223, -210, -171, -170, -136, -135 -112, -105, -76, -33, 18, 55, 107, 125, 133, 181, 186, 191, 206, 218, 224, 232, 288 ]

k = 0
res = select nums, k
