class Post < ActiveRecord::Base
  belongs_to :user, touch: :posts_updated_at

  def title
    self.body.lines.reject(&:blank?).first.try(:gsub, /\A#+\s*/, '')
  end
end
