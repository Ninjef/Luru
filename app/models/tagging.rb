class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :phrase

  validates :tag_id, presence: true
  validates :phrase_id, presence: true

  def to_s
    "#{phrase} - #{tag}"
  end
end
