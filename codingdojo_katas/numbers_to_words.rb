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

def over_hundred( number, length )

	if length == 3
		base = 100
		term = " hundred "
	elsif length > 3 && length < 7
		term = " thousand "
		base = 1000
	end
	#doesn't go >=1000000

	first = number / base
	second = number % base

	string = number_to_word(first) + term 

	if second != 0
		if second / 10 != 0
			string += number_to_word( second )
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
	when 3,4,5,6
		over_hundred( number, x )
	end
end

def word_to_number( word )
	number = []

	puts "Word To Number: #{word}"

	word.split(" ").reverse_each do |digit|
		case digit
		when "one"
			number << 1
		when "two"
			number << 2
		when "three"
			number << 3
		when "four"
			number << 4
		when "five"
			number << 5
		when "six"
			number << 6
		when "seven"
			number << 7
		when "eight"
			number << 8
		when "nine"
			number << 9
		when "zero"
			number << 0
		end
	end

	puts number
end

puts number_to_word(1)
puts number_to_word(11)
puts number_to_word(38)
puts number_to_word(101)
puts number_to_word(789)
puts number_to_word(1003)
puts number_to_word(8943)
puts number_to_word(10000)
puts number_to_word(56009)
puts number_to_word(789011)

word_to_number("one")
word_to_number("eleven")
word_to_number("thirty-eight")
word_to_number("one hundred one")
word_to_number("seven hundred eighty-nine")
word_to_number("one thousand three")
word_to_number("eight thousand nine hundred forty-three")
word_to_number("ten thousand")
word_to_number("fifty-six thousand nine")
word_to_number("seven hundred eighty-nine thousand eleven")
