class League < ActiveRecord::Base

	
	
	validates :name, presence: true, length: {maximum: 100}

	has_many :events, dependent: :destroy
	belongs_to :sport
	
	def self.search_sport(search,page)
		conditions = nil
		unless search.blank?
			condition = ['sport_id = ?', search]
		end
		paginate :per_page =>10, :page => page, :conditions => conditions
	end

end
