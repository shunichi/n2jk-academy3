class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :unreads, dependent: :destroy, as: :resource
  belongs_to :user, touch: :posts_updated_at

  validates :body, presence: true

  after_create :create_unreads

  def title
    self.body.lines.reject(&:blank?).first.try(:gsub, /\A#+\s*/, '')
  end

  def not_read_yet?(user)
    self.unreads.find_by(user: user).present?
  end

  def has_unread_comments?(user)
    self.comments.joins(:unreads).where(unreads: {user_id: user.id}).present?
  end

  private
  def create_unreads
    User.where.not(id: self.user_id).each do |user|
      self.unreads.create(user: user)
    end
  end
end
