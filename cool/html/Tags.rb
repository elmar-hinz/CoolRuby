require 'cool/html'

tags = %W(html head body div p span em strong h1 h2 h3 ul ol li)
tags = tags.collect{ |tag| tag.upcase }.each{ |tag| eval (
		"class #{tag} < Tag
			def initialize 
				super #{tag}
			end
		end" 
	)
}



