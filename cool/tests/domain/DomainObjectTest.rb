require 'minitest/autorun'
require 'cool/domain'

module Cool
	module Domain
		class DomainObjectTest < MiniTest::Unit::TestCase

			class Data1 < Cool::Domain::DomainObject
				field :id, Fixnum
				field :name, String
			end

			class Data2 < Cool::Domain::DomainObject
				field :id, Fixnum, Minimum:1, Maximum:10
				field :value1, String, Maxlength:1
				field :value2, String, Maxlength:2, Minlength:1
			end

			def setup
				@do = Cool::Domain::DomainObject.new
				@data1 = Data1.new
				@data2 = Data2.new
			end

			def test_do_instance_of_DomainObject
				assert_instance_of Cool::Domain::DomainObject, @do
			end

			def test_data1_instance_of_Datai1
				assert_instance_of Data1, @data1
			end

			def test_data2_instance_of_Datai2
				assert_instance_of Data2, @data2
			end

			def test_field_throws_for_string_key
				assert_raises TypeError do
					eval '
						class Data3 < Cool::Domain::DomainObject
							field "string_id", Fixnum
						end
					'
				end
			end

			def test_do_has_fields
				assert_instance_of Hash, @do.fields
			end

			def test_data_have_fields
				assert_instance_of Hash, @data1.fields
				assert_instance_of Hash, @data2.fields
			end

			def test_fields_of_data1_and_data2_are_not_the_same
				refute_equal @data1.fields, @data2.fields
			end

			def test_names_returns_field_keys
				assert_includes @data1.names, :id
				assert_includes @data1.names, :name
			end

			def test_new_works_with_empty_parameters
				@data1
			end

			def test_new_works_with_one_parameter
				@data1 = Data1.new name:'hello'
			end

			def test_new_works_with_multiple_parameters
				@data1 = Data1.new id:7, name:'hello'
			end

			def test_new_throws_for_invalid_index
				assert_raises IndexError do 
					Data1.new invalid_key:2
				end
			end

			def test_get_parameter_set_by_new
				@data1 = Data1.new id:7
				assert_equal 7, @data1[:id]
			end

			def test_set_and_get_valid_index
				@data1[:id] = 8
				assert_equal 8, @data1[:id]
			end

			def test_set_throws_for_invalid_index
				assert_raises IndexError do 
					@data1[:invalid] = 1 
				end
			end

			def test_errors_throws_before_validated
				assert_raises RuntimeError do 
					@do.errors
				end
				@do.validate
				assert_empty @do.errors
			end

			def test_valid_questiogn_throws_before_validated
				assert_raises RuntimeError do 
					@do.valid?
				end
				@do.validate
				assert @do.valid?
			end

			def test_validation_works
				@data2[:id] = 1
				@data2[:value1] = '1'
				@data2[:value2] = '12'
				@data2.validate
				assert @data2.valid?
				@data2[:id] = 0 
				@data2[:value1] = '12'
				@data2[:value2] = '123'
				@data2.validate
				refute @data2.valid?
			end

			def test_failed_validation_containes_expected_errors
				@data2[:id] = 11 
				@data2[:value1] = '12'
				@data2[:value2] = ''
				@data2.validate
				assert_includes @data2.errors[:id].collect{|e| e.to_s}, 'fixnum_maximum_error'
				assert_includes @data2.errors[:value1].collect{|e| e.to_s}, 'string_maxlength_error'
				assert_includes @data2.errors[:value2].collect{|e| e.to_s}, 'string_minlength_error'
			end

		end
	end
end
