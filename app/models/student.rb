class Student < ApplicationRecord
	has_many :tasks
	has_many :deals
	has_many :teachers

	validates :name, presence: true, uniqueness: true
	has_secure_password
end
