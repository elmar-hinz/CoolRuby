require 'test/unit'

class RubyTest < Test::Unit::TestCase

	def test_truth
		assert TRUE
	end

	def test_make_class
		self.class.const_set "MyHash", Class.new(Hash)
		assert_instance_of RubyTest::MyHash, MyHash.new
		assert_same MyHash, RubyTest::MyHash
		assert MyHash.new.is_a? Hash
	end

end
