require 'test/unit'
require 'cool/html'
require 'yaml'

class YamlBehaviourTest  < Test::Unit::TestCase

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

	def test_simple_load
		assert_equal 'foo', Psych.load("--- foo")
	end

	def test_simple_dump
		assert_equal "--- foo\n...\n", Psych.dump("foo")
		assert_equal "--- foo\n...\n", "foo".to_yaml
	end

	def test_load_html5_file
		spec = Psych.load_file 'cool/html/html5.yml'
		assert_includes(spec.keys, 'tags')
		assert_includes(spec['tags'].keys, 'input')
		assert_includes(spec['tags']['input']['attr'].keys, 'inputmode')
	end

	def test_load_page
		@tree = Psych.load(@page)
		assert_instance_of Hash, @tree
		assert_equal 'Example title', @tree['HTML'][0]['HEAD'][0]['TITLE']
		assert_equal 'alpha', @tree['HTML'][1]['BODY'][1]['SECTION'][0]['P']['attr']['class']
		assert_equal( 'Hello World!', 
			@tree['HTML'][1]['BODY'][1]['SECTION'][0]['P']['body'][0]['STRONG'])
	end

	def test_numbered_hash
		sentence = '--- 
sentence:
  3: Hello
  2: World
'
		assert_equal( { "sentence" => { 3 => "Hello", 2 => "World" } }, Psych.load(sentence))
		assert_equal( { "sentence" => { 2 => "World", 3 => "Hello" } }, Psych.load(sentence))
	end

	def test_flat_merging_of_hash_does_work
		sentence = '--- 
3: Moon
2: World
1: Hello
2: Sun 
'
		assert_equal( { 1 => "Hello", 2 => "Sun", 3 => "Moon" }, Psych.load(sentence))
	end

	def test_deep_merging_of_hash_does_not_work
		sentence = '--- 
sentence:
  1: Hello
  2: World
sentence:
  3: Moon
  2: Sun 
'
		assert_equal( { "sentence" => { 2 => "Sun", 3 => "Moon" } }, Psych.load(sentence))
	end

end


