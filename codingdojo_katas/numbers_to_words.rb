def tens( digit )
	case digit
	when 0
		"zero"
	when 1
		"one"
	when 2
		"two"
	when 3
		"three"
	when 4
		"four"
	when 5
		"five"
	when 6
		"six"
	when 7
		"seven"
	when 8
		"eight"
	when 9
		"nine"
	end
end

def teen( number )
	case number
	when 10
		"ten"
	when 11
		"eleven"
	when 12
		"twelve"
	when 13
		"thirteen"
	when 15
		"fifteen"
	when 18
		"eighteen"
	else
		tens(number%10)+"teen"
	end
end

puts tens( 7 )

puts tens( 0 )
puts teen( 11)
puts teen(19)
