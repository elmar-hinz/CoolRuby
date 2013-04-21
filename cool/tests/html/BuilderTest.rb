require 'test/unit'
require 'cool/html'

module Cool
	module HTML
		class  BuilderTest < MiniTest::Unit::TestCase
			
				def test_string_to_node
					assert_instance_of P, Cool::HTML::Builder.make_node('P', 'hello')
					assert_equal '<P>hello</P>', 
						Cool::HTML::Builder.make_node('P', 'hello').to_s
				end

				def test_array_to_node
					assert_equal '<P>hello-world</P>', 
						Cool::HTML::Builder.make_node('P', %W(hello - world) ).to_s
				end

				def test_attr_to_node
					assert_equal '<SPAN class="alpha" style="beta" />', 
						Cool::HTML::Builder.make_node('SPAN', {
							'attr' => {'class' => 'alpha', 'style' => 'beta'}
							}).to_s
				end

				def test_body_to_node
					assert_equal '<P>CamelCase</P>', 
						Cool::HTML::Builder.make_node('P', { 'body' => %W(Camel Case) }).to_s
				end

				def test_node_with_children
					assert_equal '<P><STRONG>Camel</STRONG><EM>Case</EM></P>', 
						Cool::HTML::Builder.make_node('P', { 
							'body' => [{'STRONG' => 'Camel'}, {'EM' => 'Case'}]
							}).to_s
				end

		end
	end
end


