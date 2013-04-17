require 'test/unit'
require 'Cool/Domain/FixnumConstraints'

module Cool
	module Domain
		class FixnumConstraintsTest < Test::Unit::TestCase
			
			def setup
				@class = Cool::Domain::FixnumConstraints
			end

			def test_class
				assert_same Cool::Domain::FixnumConstraints, @class
			end

			def test_lesser_for_negative_Fixnums
				assert -2 < -1
				assert -1 < 0
				assert -1 < 1
			end

			def test_Minimum_throws_TypeError
				assert_raise TypeError do
					@class::getInstance(:Minimum, 'string')
				end
				assert_raise TypeError do
					@class::getInstance(:Minimum, :symbol)
				end
			end

			def test_Maximum_throws_TypeError
				assert_raise TypeError do
					@class::getInstance(:Maximum, 'string')
				end
				assert_raise TypeError do
					@class::getInstance(:Maximum, :symbol)
				end
			end

			def test_get_Maximum
				constraint = @class::getInstance(:Maximum, 5)
				assert_instance_of Cool::Domain::FixnumConstraints::Maximum, constraint 
				assert_equal 5, constraint.maximum
			end

			def test_get_Minumum
				constraint = @class::getInstance(:Minimum, -3)
				assert_instance_of Cool::Domain::FixnumConstraints::Minimum, constraint 
				assert_equal -3, constraint.minimum
			end

			def test_Maximum_throws_Validation_Error
				constraint = @class::getInstance(:Maximum, 2)
				constraint.validate 1 
				constraint.validate 2 
				assert_raise ValidationError do
					constraint.validate 3
				end
				begin
					constraint.validate 3
				rescue ValidationError => ve 
					assert_equal 'fixnum_maximum_error', ve.to_s
				end
			end

			def test_Minimmum_throws_Validation_Error
				constraint = @class::getInstance(:Minimum, 2)
				constraint.validate 3
				constraint.validate 2
				assert_raise ValidationError do
					constraint.validate 1
				end
				begin
					constraint.validate 1
				rescue ValidationError => ve 
					assert_equal 'fixnum_minimum_error', ve.to_s
				end
			end

		end
	end
end

