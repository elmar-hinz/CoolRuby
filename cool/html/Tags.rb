require 'cool/html'
require 'yaml'

module Cool
	module HTML
		class Tags

			attr :specification

			def load(file = 'cool/html/html5.yml')
				@specification = Psych.load_file file
				self
			end

			def create
				@specification['tags'].each{|tag, spec| create_tag(tag, spec) }
				self
			end

			def create_tag(name, spec)
				inline = if spec.instance_of? Hash then spec['inline'] else FALSE end
				tag = name.upcase
				Module.const_get('Cool').const_get('HTML').const_set(tag, 
					Class.new(Tag) do
						define_method( :initialize ) do
							super tag, inline
						end
					end)
			end

		end
	end
end


