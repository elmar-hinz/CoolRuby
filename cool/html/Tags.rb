require 'cool/html'

module Cool
	module HTML
		class Tags
			tags = %W(html head body div p span em strong h1 h2 h3 ul ol li)
			inlines = %W(span em strong)

			def self.make_tag tag, inlines
				inline = inlines.include?(tag) 
				tag.upcase!
				Module.const_get('Cool').const_get('HTML').const_set(tag, 
					Class.new(Tag) do
						define_method( :initialize ) do
							super tag, inline
						end
					end)
			end

			tags.each{ |tag| make_tag tag, inlines}
		end
	end
end


