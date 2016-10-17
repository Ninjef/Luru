class Lesson < ActiveRecord::Base
  validates :name, presence: true
end
