#assume that there are 5 unique titles
#each costs 8 EUR
#two unique titles purchased together gets a 5% discount
# 3 titles, 10%
# 4 titles 20%
# 5 titles, 25%

class ShoppingCart

	def initialize( cart )
		@cart = cart #an array where the values are 1..5
	end

	def price
		@cart.length * 8
	end
end


