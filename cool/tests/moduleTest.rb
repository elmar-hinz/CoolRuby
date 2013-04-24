require 'test/unit'
require 'cool/module'
require 'cool/html'

module Cool
	class ModuleTest < MiniTest::Unit::TestCase

		def test_hello
			expect = "Hello from module Cool!"
			def (out=Object.new).write; end
			$stdout = out
			assert_output(expect+"\n") {
				assert_equal expect, Cool.hello
			}
			$stdout = STDOUT
		end

		def test_file
			assert Cool.file.end_with?('cool/module.rb')
		end

		def test_classify
			assert_same Cool::HTML::Tag, Cool.classify('Cool::HTML::Tag')
		end

		def test_String_classify
			assert_same Cool::HTML::Tag, 'Cool::HTML::Tag'.classify
		end

	end
end

