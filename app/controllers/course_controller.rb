class CourseController < ApplicationController
	def all
		@courses = Course.all
		render json: @courses
	end
end
