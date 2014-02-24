class Beer < ActiveRecord::Base

  include RatingAverage

  belongs_to :brewery, touch: true

  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  has_one :style

  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
  		"#{name} (#{brewery.name})"
  end

  def style
  		Style.find_by :id => style_id
  end

end
