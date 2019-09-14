module Concerns
  module Findable
    
 		def find_by_name(name)
			self.all.find{|item|item.name == name}
		end

 		def find_or_create_by_name(name)
			song = find_by_name(name)
			if song == nil
				self.create(name)
			else
				song
			end
		end

  end

end
