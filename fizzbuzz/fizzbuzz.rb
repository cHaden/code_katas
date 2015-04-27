def fizzbuzz( value )
	string = ""

	string += "Fizz" if value % 3 == 0
	string += "Buzz" if value % 5 == 0

	return string
end

(1..50).each do |x|
	if fizzbuzz( x ) == ""
		puts x
	else
		puts fizzbuzz( x )
	end
end
