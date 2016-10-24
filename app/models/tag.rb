class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :phrases, through: :taggings

  validates :name, presence: true
  validates :name, length: { maximum: 50 }

  def to_s
    name
  end
end
