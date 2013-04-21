class Tag < Array

	attr :name

	def initialize(name) 
		@attributes = Hash.new
		@name = name
	end

	def attributes
		@attributes
	end

	def []=(key, value)
		if key.instance_of? String
			@attributes[key] = value
		elsif key.instance_of? Fixnum
			super key, value
		else
			raise ArgumentError.new 'type error of key: ' + key.class.to_s
		end
	end

	def [](key)
		if key.instance_of? String
			@attributes[key]
		elsif key.instance_of? Fixnum
			super key
		else
			raise ArgumentError.new 'type error of key: ' + key.class.to_s
		end
	end

	def to_s
		ats = ''
		attributes.each{|key, value| ats += ' '+key+'="'+value+'"'}
		if self.length == 0 
			"<#{@name}#{ats} />"
		else
			body = self.reduce(''){|back, child| back += child.to_s}
			"<#{@name}#{ats}>#{body}</#{@name}>"
		end
	end

end
