require 'test/unit'
require 'cool/autoform'

module Cool
		class AutoformTest < Test::Unit::TestCase

			class Data < Cool::Domain::DomainObject
				field :given, String, Maxlength:100
			end

			def setup
				@sut = Cool::Autoform.new('Cool::AutoformTest::Data')
			end

			def test_new
				assert_same Data, @sut.domain_object
			end

			def test_is_a_tag
				assert_kind_of Cool::HTML::Tag, @sut
			end

			def test_to_s
				puts @sut
			end 

		end
end

