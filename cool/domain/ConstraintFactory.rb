module Cool
	module Domain
		class ConstraintFactory
			def self.getInstance(classname, parameters)
				classname = self.to_s + '::' + classname.to_s
				classname.split('::').reduce(Object){|cls, c| cls.const_get(c) }.new parameters
			end
		end
	end
end
