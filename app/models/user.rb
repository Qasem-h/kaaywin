class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, length: {minimum: 6}

	belongs_to :role

	has_many :tickets # a ticket can also belong to a scrathcard
	has_many :transactions



		def User.new_remember_token  # generates a random string
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s) # used to encrypt a random string
	end

	def balance  # this method is used to know how much money a user has lef
		self.transactions.to_a.sum(&:amount)
	end

	



	private
	def create_remember_token # encrypt a randon string generated for this user to create a remember token
		self.remember_token = User.encrypt(User.new_remember_token)
	end

end
