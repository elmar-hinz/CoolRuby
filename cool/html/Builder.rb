require 'cool/html'

module Cool
	module HTML
		module Builder

			def self.tree(configuration)
				make_node('HTML', configuration['HTML'])
			end

			def self.make_node(classname, configuration)
				tag = Object.const_get(classname).new
				if(configuration.instance_of? String) 
					tag << configuration
				elsif(configuration.instance_of? Array)
					add_children(tag, configuration)
				elsif(configuration.instance_of? Hash)
					if(configuration['attr'].instance_of? Hash)
						configuration['attr'].each{|key, value| tag.attributes[key] = value }
					end
					if(configuration['body'].instance_of? Array)
						add_children(tag, configuration['body'])
					end
				else
					raise TypeError, 'Unexepected Type of configuration'
				end
				return tag
			end

			def self.add_children(tag, children)
				raise TypeError, 'No Array' unless children.instance_of? Array
				children.each do |child|
					if(child.instance_of? String) 
						tag << child
					elsif(child.instance_of? Hash)
						classname = child.first[0]
						configuration = child.first[1]
						tag << make_node(classname, configuration)
					else
						raise TypeError, 'Unexepected Type of configuration'
					end
				end
			end

		end
	end
end
