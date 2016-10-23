class Phrase < ActiveRecord::Base
  belongs_to :lesson
  has_many :taggings
  has_many :tags, through: :taggings

  validates :text, presence: true
  validates :image_search_text, presence: true

  def to_s
    text
  end

  def next_in_lesson
    Lesson.find(self.lesson_id)
          .phrases
          .where("lesson_order > ?", self.lesson_order)
          .order("lesson_order asc")
          .first
  end

  def previous_in_lesson
    Lesson.find(self.lesson_id)
          .phrases
          .where("lesson_order < ?", self.lesson_order)
          .order("lesson_order desc")
          .first
  end
end
