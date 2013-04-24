require 'cool/module'
require 'cool/html'
require 'cool/domain'

module Cool
	class Autoform < Cool::HTML::Tag
		
		attr :domain_object
		
		def initialize domain_object
			super 'FORM'
			@ul = Cool::HTML::UL.new
			@domain_object = domain_object.classify
			@domain_object.fields.each do |name, definition|  
				create_field name, definition
			end
			self << @ul
		end

		def create_field name, definition
			name = name.to_s
			li = Cool::HTML::LI.new 
			label = Cool::HTML::LABEL.new
			label << name
			input =  Cool::HTML::INPUT.new
			input['name'] = name
			input['id'] = name
			li << label << input
			@ul << li
		end

	end
end

