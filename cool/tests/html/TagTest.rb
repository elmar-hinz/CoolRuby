require 'test/unit'
require 'cool/html'

module Cool
	module HTML
		class TagTest< Test::Unit::TestCase

			def setup
				@tag = Tag.new 'TEST', TRUE
			end

			def test_is_a_Tag
				assert_instance_of Tag, @tag
			end

			def test_inline_defaults_to_FALSE
				assert @tag.inline
				@tag = Tag.new 'TEST'
				refute @tag.inline
			end

			def test_name
				assert_equal 'TEST', @tag.name
			end

			def test_has_attributes
				assert_instance_of Hash, @tag.attributes
			end

			def test_has_body
				assert_instance_of Array, @tag.body
			end

			def test_access_body_by_number_shortcut
				@tag[3] = 3
				assert_equal @tag[3], 3
				assert_equal @tag.body[3], 3
			end

			def test_access_attributes_by_string_shortcut
				@tag['testattribute'] = 3
				assert_equal @tag['testattribute'], 3
				assert_equal @tag.attributes['testattribute'], 3
			end

			def test_number_keys_dont_set_attributes
				@tag[3] = 3
				assert_not_equal @tag.attributes[3], 3
			end

			def test_iterator_dont_contains_attributes
				@tag[0] = 0
				@tag[1] = 1
				@tag['first'] = 'one'
				assert_equal '*0*1*', @tag.inject('*') {|sum,value| sum+value.to_s+'*'}
			end

			def test_setter_throws_ArgumentError
				assert_raise ArgumentError do 
					@tag[3.3] = 3.3
				end
			end

			def test_getter_throws_ArgumentError
				assert_raise ArgumentError do 
					@tag[3.3] 
				end
			end

			def test_simple_tag_to_s
				assert_equal '<TEST />', @tag.to_s
			end

			def test_one_child_to_s
				@tag << 'hello'
				assert_equal '<TEST>hello</TEST>', @tag.to_s
			end

			def test_two_children_to_s
				@tag << 'Hello ' << 'world!'
				assert_equal '<TEST>Hello world!</TEST>', @tag.to_s
			end

			def test_one_attribute
				@tag.attributes['class'] = "world"
				assert_equal '<TEST class="world" />', @tag.to_s
			end

			def test_two_attributes
				@tag.attributes['class'] = "world"
				@tag.attributes['style'] = "color:red"
				assert_equal '<TEST class="world" style="color:red" />', @tag.to_s
			end

			def test_one_child_one_tag
				@tag << 'hello'
				@tag.attributes['class'] = "world"
				assert_equal '<TEST class="world">hello</TEST>', @tag.to_s
			end

			def test_one_child_two_tags
				@tag << 'hello'
				@tag.attributes['class'] = "world"
				@tag.attributes['style'] = "color:red"
				assert_equal '<TEST class="world" style="color:red">hello</TEST>', @tag.to_s
			end

			def test_element_tag_formatting
				@tag = Tag.new 'HR'
				assert_equal "<HR />\n", @tag.to_s
				@tag.depth = 1 
				assert_equal "  <HR />\n", @tag.to_s
				@tag.depth = 2 
				assert_equal "    <HR />\n", @tag.to_s
			end

			def test_block_tag_foramatting
				@tag = Tag.new 'P'
				@tag << 'hello'
				assert_equal "<P>\nhello</P>\n", @tag.to_s
				@tag.depth = 1 
				assert_equal "  <P>\nhello  </P>\n", @tag.to_s
			end

			def test_inline_tag_formatting
				@tag = Tag.new 'SPAN', TRUE
				@tag << 'hello'
				@tag.depth = 99 
				assert_equal "<SPAN>hello</SPAN>", @tag.to_s
				@tag = Tag.new 'IMAGE', TRUE
				@tag.depth = 99 
				assert_equal "<IMAGE />", @tag.to_s
			end

		end
	end
end
