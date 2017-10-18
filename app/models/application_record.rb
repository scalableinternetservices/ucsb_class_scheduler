class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_courses_in_json
    obj = JSON.parse(File.read('hard_coded_courses.json'))
  end
end
