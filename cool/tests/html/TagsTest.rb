require 'test/unit'
require 'cool/html'

module Cool
	module HTML
		class TagsTest < Test::Unit::TestCase

			def setup
				@sut = Tags.new
				@tags = %W(html head body div p span em strong h1 h2 h3 ul ol li)
				@tags.collect{ |tag| tag.upcase }.each do |tag|
					eval ("@#{tag.downcase} = #{tag}.new")
				end
			end

			def test_new
				assert_instance_of Tags, @sut
			end

			def test_load
				@sut.load
				assert_includes(@sut.specification['tags']['input']['attr'].keys, 'inputmode')
			end

			def test_known_Tags
				assert_instance_of HTML, @html
				assert_instance_of HEAD, @head
				assert_instance_of BODY, @body
				assert_instance_of DIV, @div
				assert_instance_of H1, @h1 
				assert_instance_of H2, @h2 
				assert_instance_of H3, @h3 
				assert_instance_of P, @p
				assert_instance_of UL, @ul
				assert_instance_of OL, @ol 
				assert_instance_of LI, @li 
				assert_instance_of SPAN, @span
				assert_instance_of EM, @em
				assert_instance_of STRONG, @strong 
				assert_equal 'STRONG', STRONG.new.name
				assert_equal 'P', P.new.name
			end

			def test_inline_tags
				[SPAN, EM, STRONG].each { |klass| assert klass.new.inline	}
				refute DIV.new.inline
			end

		end
	end
end

