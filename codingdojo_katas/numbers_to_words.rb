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

def tens_place( number )
	first = number / 10
	second = number % 10

	string = ""

	case first
	when 1
		return teen( number )
	when 2
		string = "twenty"
	when 3
		string = "thirty"
	when 4
		string = "forty"
	when 5
		string = "fifty"
	when 6
		string = "sixty"
	when 7
		string = "seventy"
	when 8
		string = "eighty"
	when 9
		string = "ninety"
	end

	string += "-" + tens(second) if second != 0

	return string
end

def hundreds_place( number )
	first = number / 100
	second = number % 100

	string = tens(first) + " hundred "

	if second != 0
		if second / 10 != 0
			string += tens_place( second )
		else
			string += tens( second % 10 )
		end
	end

	return string
end 

def number_to_word( number )
		x = number.to_s.length
		case x
		when 1
			tens( number )
		when 2
			tens_place( number )
		when 3
			hundreds_place( number )
		end
	end
puts tens( 7 )

puts tens( 0 )
puts teen( 11)
puts teen(19)

puts number_to_word(4)
puts number_to_word(20)
puts number_to_word(49)
puts number_to_word(14)
puts number_to_word(11)
puts number_to_word(100)
puts number_to_word(204)
puts number_to_word(739)
