require 'test/unit'
require 'cool/domain'

module Cool
	module Domain
		class ValidationErrorTest < Test::Unit::TestCase
			
			def setup
				@sut = ValidationError.new :error_id
			end

			def test_creation
				assert_instance_of Cool::Domain::ValidationError, @sut
			end
			
			def test_errorid
				assert_equal 'error_id', @sut.to_s
				assert_equal :error_id, @sut.id
			end
			
			def test_throws_type_error_for_string_argument
				assert_raise TypeError do
					ValidationError.new 'error_id'
				end
			end
			
		end
	end
end
