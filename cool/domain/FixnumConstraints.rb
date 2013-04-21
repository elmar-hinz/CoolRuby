require 'cool/domain'

module Cool
	module Domain 
		class FixnumConstraints < ConstraintFactory

			class Maximum < AbstractConstraint
				attr_reader :maximum

				def initialize(max)
					raise TypeError, 'No Fixnum' unless max.instance_of? Fixnum
					@maximum = max
				end

				def validate(fixnum)
					raise TypeError, 'No Fixnum' unless fixnum.instance_of? Fixnum
					unless fixnum <= @maximum
						raise ValidationError, :fixnum_maximum_error
					end
				end

			end

			class Minimum < AbstractConstraint
				attr_reader :minimum

				def initialize(minimum)
					raise TypeError, 'No Fixnum' unless minimum.instance_of? Fixnum
					@minimum = minimum
				end

				def validate(fixnum)
					raise TypeError, 'No Fixnum' unless fixnum.instance_of? Fixnum
					unless fixnum >= @minimum
						raise ValidationError, :fixnum_minimum_error
					end
				end
			end

		end
	end
end
