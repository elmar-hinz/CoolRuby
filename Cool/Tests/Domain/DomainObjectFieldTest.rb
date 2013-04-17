require 'minitest/autorun'
require 'Cool/Domain/DomainObjectField'

module Cool
	module Domain
		class DomainObjectFieldTest < MiniTest::Unit::TestCase

			def setup 
				@sut = DomainObjectField.new String, Maxlength:2
			end

			def test_object_class
				assert_instance_of DomainObjectField, @sut
			end

			def test_constraint
				assert_instance_of Cool::Domain::StringConstraints::Maxlength, @sut.constraints[0]
				assert_equal 2, @sut.constraints[0].maxlength
			end

			def test_initialize_throws_typeError_for_type
				assert_raises TypeError do
					DomainObjectField.new :String, Maxlength:2
				end
			end

		end
	end
end

