require 'test/unit'
require 'yaml'
require 'cool/html'

class TagTest< Test::Unit::TestCase

	def setup
		@page = '
%YAML 1.1
--- 
HTML:
- HEAD:
  - TITLE: Example title
- BODY:
  - HEADER:
    - H1: Example of a YAML HTML
  - SECTION:
    - P: 
        attr: { class: "alpha", style: "color:blue" }
        body:
        - STRONG: Hello World!
        - EM: What else?
  - FOOTER:
    - HR: {class: "ruler"}
'
	end

	def testSimpleLoad
		assert_equal 'foo', Psych.load("--- foo")
	end

	def testSimpleDump
		assert_equal "--- foo\n...\n", Psych.dump("foo")
		assert_equal "--- foo\n...\n", "foo".to_yaml
	end

	def testDumpTag
		tag = Tag.new "HELLO"
		expect = "--- !ruby/array:Tag\ninternal: []\nivars:\n  :@attributes: {}\n  :@name: HELLO\n"
		assert_equal expect, tag.to_yaml
	end

	def testLoadPage
		@tree = Psych.load(@page)
		assert_instance_of Hash, @tree
		assert_equal 'Example title', @tree['HTML'][0]['HEAD'][0]['TITLE']
		assert_equal 'alpha', @tree['HTML'][1]['BODY'][1]['SECTION'][0]['P']['attr']['class']
		assert_equal( 'Hello World!', 
			@tree['HTML'][1]['BODY'][1]['SECTION'][0]['P']['body'][0]['STRONG'])
	end

end

