module Cool
	module Domain 
		class DomainObject
			
			def initialize(parameters = {})
				@validated = FALSE
				@errors = Hash.new
				@data = Hash.new
				names.each{|name| @data[name] = nil}
				parameters.each{|key, value| self[key] = value}
			end

			def names
				fields.keys
			end

			def [](key)
				raise IndexError, 'Invalid key :'+ key.to_s unless names.include? key 
				@data[key]
			end

			def []=(key, value)
				raise IndexError, 'Invalid key :'+key.to_s unless names.include? key 
				@data[key] = value
			end

			def validate
				fields.each do |name, field| 
					field.constraints.each do |constraint|
						begin
							constraint.validate self[name]	
						rescue Cool::Domain::ValidationError => error
							@errors[name] ||= [] 
							@errors[name] << error
						end
					end
				end
				@validated = TRUE
			end

			def valid?
				errors.empty?
			end

			def errors
				raise RuntimeError, 'Not validated yet' unless @validated
				@errors
			end

			def fields
				self.class.fields
			end

			class << self
				def fields
					@fields ||= {}
				end
				def field(name, type, constraints = [])
					raise TypeError, 'Field name must by Symbol'  unless name.instance_of? Symbol
					fields[name] = DomainObjectField.new(type, constraints)
				end
			end

		end
	end
end
