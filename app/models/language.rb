class Language < ActiveRecord::Base
  validates :name, presence: true
  validates :code, presence: true

  def to_s
    name
  end
end
