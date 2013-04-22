require 'cool/html'

module Cool
	module HTML

		tags = %W(html head body div p span em strong h1 h2 h3 ul ol li)
		inlines = %W(span em strong)

		tags.each{ |tag| 
			inline = inlines.include?(tag) 
			tag = tag.upcase
			eval (
				"class #{tag} < Tag
					def initialize 
						super '#{tag}', #{inline}
					end
				end" 
			)
		}

	end
end


