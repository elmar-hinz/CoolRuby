require 'test/unit'
require 'cool/html'

class TagTest< Test::Unit::TestCase

	def setup
		@tag = Tag.new 'TEST'
	end

	def test_is_a_node
		assert_instance_of Tag, @tag
	end

	def test_name
		assert_equal 'TEST', @tag.name
	end

	def test_kind_of_array
		assert_kind_of Array, @tag
	end

	def test_has_attributes
		assert_instance_of Hash, @tag.attributes
	end

	def test_access_childnode_by_number
		@tag[3] = 3
		assert_equal @tag[3], 3
	end

	def test_numbers_dont_set_attributes
		@tag[3] = 3
		assert_not_equal @tag.attributes[3], 3
	end

	def test_access_attribute_by_string
		@tag['testattribute'] = 3
		assert_equal @tag['testattribute'], 3
		assert_equal @tag.attributes['testattribute'], 3
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

end
