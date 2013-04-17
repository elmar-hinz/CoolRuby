require 'Cool/Domain/StringConstraints'
require 'Cool/Domain/AbstractConstraint'

module Cool
	module Domain 
		class DomainObjectField

			attr :type, :constraints

			def initialize(type, constraints)
				raise TypeError, 'Type name must be a class'  unless type.instance_of? Class
				@type = type
				@constraints = build_constraints(constraints)
			end

			def build_constraints(constraints)
					list = []
					constraints.each do |key, value|
						factory= type.to_s + 'Constraints'
						factoryclass = Object.const_get('Cool').const_get('Domain').const_get(factory)   
						list <<  factoryclass::getInstance(key, value)
					end
					list
			end

		end
	end
end
			

