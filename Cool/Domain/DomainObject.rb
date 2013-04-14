class DomainObject

	class << self

		def field(name, type, constraints = [])
			fields = fields()
			fields[name] = {type:type, constraints:constraints}
		end

		def fields
			@fields ||= {}
		end

	end

	def fields
		self.class.fields
	end

end
