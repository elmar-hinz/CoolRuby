module Cool

	def self.hello
		hello = 'Hello from module Cool!'
		puts hello
		hello
	end

	def self.file
		__FILE__
	end

	def self.classify name
		name.split('::').reduce(Object){|cls, c| cls.const_get(c) }
	end

	class Object::String
		def classify
			Cool.classify self
		end
	end

end
