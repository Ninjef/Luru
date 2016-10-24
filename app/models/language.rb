class Language < ActiveRecord::Base
  validates :name, presence: true
  validates :code, presence: true

  def url_parameter
    "?lang=#{code}"
  end

  def to_s
    name
  end
end
