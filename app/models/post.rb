class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user, touch: :posts_updated_at

  validates :body, presence: true

  def title
    self.body.lines.reject(&:blank?).first.try(:gsub, /\A#+\s*/, '')
  end
end
