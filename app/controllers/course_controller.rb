class CourseController < ApplicationController
	before_action :authenticate_user, only: [:like, :comment]

	def all
		find_courses_sql = <<-SQL
			SELECT courses.*, COALESCE(SUM(course_likes.amount), 0) as likes
			FROM courses LEFT JOIN course_likes ON course_likes.course_id = courses.id
			GROUP BY courses.id;
		SQL

		@courses = ActiveRecord::Base.connection.execute(find_courses_sql)
		render json: @courses
	end

	def like
		@like = CourseLike.find_or_create_by(user: current_user, course_id: params[:id])
		@like.amount += 1
		@like.save!
		render json: @like
	rescue ActiveRecord::RecordNotFound
	rescue ActiveRecord::InvalidForeignKey
	rescue ActiveRecord::RecordInvalid
		render json: { status: 'failed' }, status: 500
	end

	def comment
		course = Course.find(params[:id])
		parent_id = params[:parent_id]
		user = current_user
		@comment = Comment.create!(course_id: course.id, user_id: user.id, content: params[:content], parent_id: parent_id)

		render json: @comment
	rescue ActiveRecord::RecordNotFound
	rescue ActiveRecord::InvalidForeignKey
		render json: { status: 'failed' }, status: 500
	end

	def show
		course = Course.find(params[:id])
		render json: course.to_json(include: :comments)
	rescue ActiveRecord::RecordNotFound
		render json: { status: 'failed' }, status: 500
	end
end
