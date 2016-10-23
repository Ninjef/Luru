class Lesson < ActiveRecord::Base
  has_many :phrases

  validates :name, presence: true

  def to_s
    name
  end

  def first_phrase
    self.phrases.order("lesson_order asc").first
  end

  def phrase_tags
    # Get all the tags related to all phrases in current lesson
    tags = []
    self.phrases.each do |phrase|
      tags += phrase.tags.map { |tag| tag.name }
    end
    tags.uniq!
  end
end
