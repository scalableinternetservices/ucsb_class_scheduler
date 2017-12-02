class AggregateCoursesJob < ApplicationJob
	queue_as :default

	def perform(*args)
		temp_table_name = 'course_likes_temp'
		create_temp_table_sql = generate_temp_table_sql(temp_table_name)

		ActiveRecord::Base.transaction do
			ActiveRecord::Base.connection.execute(create_temp_table_sql)
			ActiveRecord::Base.connection.execute(generate_index_sql(temp_table_name))
		end
	end

private
	def generate_temp_table_sql(table_name)
		<<-SQL
			CREATE TEMP TABLE #{table_name}
			AS SELECT courses.*, COALESCE(SUM(course_likes.amount), 0) as likes
			FROM courses
			LEFT JOIN course_likes ON course_likes.course_id = courses.id
			GROUP BY courses.id
			ORDER BY likes;
		SQL
	end

	def generate_index_sql(table_name)
		<<-SQL
	    	#{course_pkey(table_name)}
	    	#{instructor_dept_course_index(table_name)}
	    	#{instructor_index(table_name)}
	    SQL
	end

	def course_pkey(table_name)
		<<-SQL
			CREATE UNIQUE INDEX courses_pkey ON #{table_name} USING btree (id);
		SQL
	end

	def instructor_dept_course_index(table_name)
		<<-SQL
			CREATE UNIQUE INDEX index_courses_on_instructor_id_and_dept_and_course_no
	    	ON #{table_name} USING btree (instructor_id, dept, course_no);
		SQL
	end

	def instructor_index(table_name)
		<<-SQL
			CREATE INDEX index_courses_on_instructor_id ON #{table_name} USING btree (instructor_id);
		SQL
	end
end
