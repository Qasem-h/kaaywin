class League < ActiveRecord::Base

	before_save {self.name = name.downcase}
	
	validates :name, presence: true, length: {maximum: 100}

	has_many :events, dependent: :destroy
	belongs_to :sport
	

end
