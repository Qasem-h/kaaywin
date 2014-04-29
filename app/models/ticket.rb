class Ticket < ActiveRecord::Base

	belongs_to :user
	has_many :bet_item_clones, dependent: :destroy
end
