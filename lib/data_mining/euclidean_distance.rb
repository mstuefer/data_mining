def euclidean_distance(p1, p2)
  p1 = p1.value
  p2 = p2.value
  Math.sqrt(
    p1.each_with_index.inject(0) do |sum, (v, i)|
      sum + ((v - p2[i])**2)
    end
  )
end
