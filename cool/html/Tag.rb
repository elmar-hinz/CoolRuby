module Cool
	module HTML
		class Tag 
			
			include Enumerable
			attr :name, :attributes, :body, :inline, :depth
			attr_accessor :depth

			def initialize name, inline = FALSE
				@name = name
				@body = Array.new
				@attributes = Hash.new
				@depth = 0
				@inline = inline
			end

			def []= key, value
				if key.instance_of? String
					@attributes[key] = value
				elsif key.instance_of? Fixnum
					@body[key] = value
				else
					raise ArgumentError.new 'type error of key: ' + key.class.to_s
				end
			end

			def [] key
				if key.instance_of? String
					@attributes[key]
				elsif key.instance_of? Fixnum
					@body[key]
				else
					raise ArgumentError.new 'type error of key: ' + key.class.to_s
				end
			end

			def << value
				@body << value
			end

			def each
				@body.each{ |x| yield x }
			end

			def to_s
				attr = prepend = linebreak = '' 
				unless @inline 
					prepend = '  ' * @depth
					linebreak = "\n" 
				end
				@attributes.each{|key, value| attr += ' '+key+'="'+value+'"'}
				if @body.length == 0 
					prepend + "<#{@name}#{attr} />" + linebreak
				else
					body = @body.reduce(''){|back, child| back += child.to_s}
					prepend + "<#{@name}#{attr}>"  + linebreak + 
					body + prepend + "</#{@name}>" + linebreak
				end
			end

		end
	end
end
