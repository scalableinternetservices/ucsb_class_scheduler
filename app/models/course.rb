class Course < ApplicationRecord
	belongs_to :instructor
	has_many :periods, dependent: :destroy
end
