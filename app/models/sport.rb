class Sport < ActiveRecord::Base

	has_many :leagues, dependent: :destroy
end
