module Cool
	module Domain
		class ValidationError < StandardError

			attr :id
			
			def initialize(errorid)
				raise TypeError unless errorid.instance_of? Symbol 
				@id = errorid
				super errorid.to_s
			end

		end
	end
end

