class Course < ApplicationRecord
	belongs_to :instructor
	has_many :course_likes, dependent: :delete_all
	has_many :periods, dependent: :destroy
	has_many :comments, dependent: :destroy
end
