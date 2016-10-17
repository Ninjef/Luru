class Phrase < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :text, presence: true
  validates :image_search_text, presence: true
end
