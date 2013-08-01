class Movie < ActiveRecord::Base
	class << self
		def all_ratings
			select('DISTINCT rating').all.map(&:rating)
		end
	end
end
