require 'test/unit'
require 'DomainObject.rb'

class DomainObjectTest < Test::Unit::TestCase

	class Data1 < DomainObject
		field :id, Fixnum
		field :name, String
	end

	class Data2 < DomainObject
		field :id, Fixnum
		field :value, String
	end

	def setup
		@do = DomainObject.new
		@data1 = Data1.new
		@data2 = Data2.new
	end

	def test_do_instance_of_DomainObject
		assert_instance_of DomainObject, @do
	end

	def test_data1_instance_of_Datai1
		assert_instance_of Data1, @data1
	end

	def test_data2_instance_of_Datai2
		assert_instance_of Data2, @data2
	end

	def test_do_has_fields
		assert_instance_of Hash, @do.fields
	end

	def test_data_have_fields
		assert_instance_of Hash, @data1.fields
		assert_instance_of Hash, @data2.fields
	end

	def test_fields_of_data1_and_data2_are_not_the_same
		assert_not_equal @data1.fields, @data2.fields
	end

end
