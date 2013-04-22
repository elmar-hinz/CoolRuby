require 'test/unit'
require 'cool/html'

module Cool
	module HTML
		class  BuilderTest < MiniTest::Unit::TestCase
			
				def test_string_to_node
					assert_instance_of SPAN, Cool::HTML::Builder.make_node('SPAN', 'hello')
					assert_equal '<SPAN>hello</SPAN>', 
						Cool::HTML::Builder.make_node('SPAN', 'hello').to_s
				end

				def test_array_to_node
					assert_equal '<SPAN>hello-world</SPAN>', 
						Cool::HTML::Builder.make_node('SPAN', %W(hello - world) ).to_s
				end

				def test_attr_to_node
					assert_equal '<SPAN class="alpha" style="beta" />', 
						Cool::HTML::Builder.make_node('SPAN', {
							'attr' => {'class' => 'alpha', 'style' => 'beta'}
							}).to_s
				end

				def test_body_to_node
					assert_equal '<SPAN>CamelCase</SPAN>', 
						Cool::HTML::Builder.make_node('SPAN', { 'body' => %W(Camel Case) }).to_s
				end

				def test_node_with_children
					assert_equal "<P>\n<STRONG>Camel</STRONG><EM>Case</EM></P>\n", 
						Cool::HTML::Builder.make_node('P', { 
							'body' => [{'STRONG' => 'Camel'}, {'EM' => 'Case'}]
							}).to_s
				end

		end
	end
end


