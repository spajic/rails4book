class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  after_destroy :ensure_at_least_one_admin_remains
  has_secure_password

  private
  	def ensure_at_least_one_admin_remains
  		if User.count.zero?
  			raise "Последний администратор не может быть удалён"
  		end
  	end
end
