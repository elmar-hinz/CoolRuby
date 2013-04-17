require 'Cool/Domain/ConstraintFactory'
require 'Cool/Domain/AbstractConstraint'
require 'Cool/Domain/ValidationError'

module Cool
	module Domain 
		class StringConstraints < ConstraintFactory

			class Minlength < AbstractConstraint
				attr_reader :minlength

				def initialize(minlength)
					raise TypeError, 'No Fixnum' unless minlength.instance_of? Fixnum
					raise RangeError, 'Minlength below zero' if minlength < 0
					@minlength = minlength 
				end

				def validate(string)
					raise TypeError, 'No String' unless string.instance_of? String
					unless string.length >= @minlength
						raise ValidationError.new :string_minlength_error
					end
				end
			end

			class Maxlength < AbstractConstraint
				attr_reader :maxlength

				def initialize(maxlength)
					raise TypeError, 'No Fixnum' unless maxlength.instance_of? Fixnum
					@maxlength = maxlength
				end

				def validate(string)
					raise TypeError, 'No String' unless string.instance_of? String
					unless string.length <= @maxlength
						raise ValidationError.new :string_maxlength_error
					end
				end
			end

		end
	end
end

