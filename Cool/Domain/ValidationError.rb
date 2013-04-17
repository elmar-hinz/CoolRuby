module Cool
	module Domain
		class ValidationError < StandardError
			
			def initialize(errorid)
				raise TypeError unless errorid.instance_of? Symbol 
				super 
			end

		end
	end
end

