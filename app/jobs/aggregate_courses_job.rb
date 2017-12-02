class AggregateCoursesJob < ApplicationJob
	queue_as :default

	def perform(*)
		Rails.logger.info "aggregate courses job started"
		temp_table_name = 'course_likes_temp'

		ActiveRecord::Base.transaction do
			safe_replace_table(temp_table_name) do
				ActiveRecord::Base.connection.execute(generate_temp_table_sql(temp_table_name + '_new'))
			end
			ActiveRecord::Base.connection.execute(generate_index_sql(temp_table_name, Time.now.to_formatted_s(:number)))
		end
		Rails.logger.info "aggregate courses job started"
	end

		private

	def safe_replace_table(temp_table_name)
		yield
		ActiveRecord::Base.connection.execute(alter_table_if_exists(temp_table_name))
		ActiveRecord::Base.connection.execute(rename_table(temp_table_name + '_new', temp_table_name))
		ActiveRecord::Base.connection.execute(drop_table_if_exists(temp_table_name + '_old'))
	end

	def rename_table(old_table_name, new_table_name)
		<<-SQL
			ALTER TABLE "#{old_table_name}"
			RENAME TO "#{new_table_name}"
		SQL
	end

	def alter_table_if_exists(table_name)
		<<-SQL
			ALTER TABLE IF EXISTS "#{table_name}"
			RENAME TO "#{table_name + '_old'}"
		SQL
	end

	def drop_table_if_exists(table_name)
		<<-SQL
			DROP TABLE IF EXISTS "#{table_name}"
		SQL
	end

	def generate_temp_table_sql(table_name)
		<<-SQL
			CREATE TABLE "#{table_name}"
			AS SELECT courses.*, COALESCE(SUM(course_likes.amount), 0) as likes
			FROM courses
			LEFT JOIN course_likes ON course_likes.course_id = courses.id
			GROUP BY courses.id
		SQL
	end

	def generate_index_sql(*args)
		<<-SQL
	    	#{course_pkey(*args)}
	    	#{instructor_dept_course_index(*args)}
	    	#{instructor_index(*args)}
	    	#{likes_index(*args)}
	    SQL
	end

	def course_pkey(table_name, timestamp)
		<<-SQL
			CREATE UNIQUE INDEX courses_pkey_#{timestamp} ON "#{table_name}" USING btree (id);
		SQL
	end

	def instructor_dept_course_index(table_name, timestamp)
		<<-SQL
			CREATE UNIQUE INDEX index_courses_on_instructor_id_and_dept_and_course_no_#{timestamp}
	    	ON "#{table_name}" USING btree (instructor_id, dept, course_no);
		SQL
	end

	def instructor_index(table_name, timestamp)
		<<-SQL
			CREATE INDEX index_courses_on_instructor_id_#{timestamp} ON "#{table_name}" USING btree (instructor_id);
		SQL
	end

	def likes_index(table_name, timestamp)
		<<-SQL
			CREATE INDEX index_courses_on_likes_#{timestamp} ON "#{table_name}" USING btree (likes);
		SQL
	end
end
