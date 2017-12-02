class CourseController < ApplicationController
	before_action :authenticate_user, only: [:like, :comment]

	def preview
		preview_courses_sql = generate_preview_courses_sql(params[:page])

		@courses = ActiveRecord::Base.connection.execute(preview_courses_sql)
		render json: @courses
	end

	def filter
		filter_conditions = []
		filter_conditions.push("dept='#{params[:dept]}'") unless params[:dept].nil?

		filter_courses_sql = generate_filter_courses_sql(filter_conditions, params[:page])

		@courses = ActiveRecord::Base.connection.execute(filter_courses_sql)
		render json: @courses
	end

	def like
		@like = CourseLike.find_or_create_by(user: current_user, course_id: params[:id])
		@like.amount += 1
		@like.save!
		render json: @like
	rescue ActiveRecord::RecordNotFound, ActiveRecord::InvalidForeignKey, ActiveRecord::RecordInvalid
		render json: { status: 'failed' }, status: 500
	end

	def comment
		course = Course.find(params[:id])
		user = current_user
		@comment = Comment.create!(course_id: course.id, user_id: user.id, content: params[:content])

		render json: @comment
	rescue ActiveRecord::RecordNotFound, ActiveRecord::InvalidForeignKey, ActiveRecord::RecordInvalid
		render json: { status: 'failed' }, status: 500
	end

	def show
		course = Course.find(params[:id])
		render json: course.to_json(include: :comments)
	rescue ActiveRecord::RecordNotFound
		render json: { status: 'failed' }, status: 500
	end

		private

	def generate_preview_courses_sql(page = nil)
		offset_sql = "OFFSET #{25 * params[:page].to_i}" unless page.nil?

		<<-SQL
			SELECT *
			FROM course_likes_temp
			ORDER BY likes DESC
			LIMIT 25
			#{offset_sql};
		SQL
	end

	def generate_filter_courses_sql(filter_conditions, page = nil)
		offset_sql = "OFFSET #{25 * params[:page].to_i}" unless page.nil?

		<<-SQL
			SELECT *
			FROM course_likes_temp
			#{'WHERE ' + filter_conditions.join(' AND ') if filter_conditions.present?}
			ORDER BY likes DESC
			LIMIT 25
			#{offset_sql};
		SQL
	end
end
