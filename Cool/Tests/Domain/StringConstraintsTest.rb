require 'test/unit'
require 'Cool/Domain/StringConstraints'

module Cool
	module Domain
		class StringConstraintsTest < Test::Unit::TestCase
			
			def setup
				@class = Cool::Domain::StringConstraints
			end

			def test_class
				assert_same Cool::Domain::StringConstraints, @class
			end

			def test_get_Minlength
				constraint = @class::getInstance(:Minlength, 3)
				assert_instance_of Cool::Domain::StringConstraints::Minlength, constraint 
				assert_equal 3, constraint.minlength
			end

			def test_get_Maxlength
				constraint = @class::getInstance(:Maxlength, 5)
				assert_instance_of Cool::Domain::StringConstraints::Maxlength, constraint 
				assert_equal 5, constraint.maxlength
			end

			def test_Minlength_throws_TypeError
				assert_raise TypeError do
					@class::getInstance(:Minlength, 'string')
				end
				assert_raise TypeError do
					@class::getInstance(:Minlength, :symbol)
				end
			end

			def test_Maxlength_throws_TypeError
				assert_raise TypeError do
					@class::getInstance(:Maxlength, 'string')
				end
				assert_raise TypeError do
					@class::getInstance(:Maxlength, :symbol)
				end
			end

			def test_Minlength_throws_RangeError
				@class::getInstance(:Minlength, 1)
				@class::getInstance(:Minlength, 0)
				assert_raise RangeError do
					@class::getInstance(:Minlength, -1)
				end
			end

			def test_Minlength_throws_Validation_Error
				constraint = @class::getInstance(:Minlength, 2)
				constraint.validate '123'
				constraint.validate '12'
				assert_raise ValidationError do
					constraint.validate '1'
				end
				begin
					constraint.validate '1'
				rescue ValidationError => ve 
					assert_equal 'string_minlength_error', ve.to_s
				end
			end

			def test_Maxlength_throws_Validation_Error
				constraint = @class::getInstance(:Maxlength, 2)
				constraint.validate ''
				constraint.validate '12'
				assert_raise ValidationError do
					constraint.validate '123'
				end
				begin
					constraint.validate '123'
				rescue ValidationError => ve 
					assert_equal 'string_maxlength_error', ve.to_s
				end
			end

		end
	end
end

