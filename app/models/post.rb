class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :unreads, dependent: :destroy, as: :resource
  belongs_to :user, touch: :posts_updated_at

  validates :body, presence: true

  after_create :create_unreads

  def title
    self.body.lines.reject(&:blank?).first.try(:gsub, /\A#+\s*/, '')
  end

  def unread_for(user)
    self.unreads.find_by(user: user)
  end

  def not_read_yet?(user)
    unread_for(user).present?
  end

  def unread_comments_for(user)
    self.comments.joins(:unreads).where(unreads: {user_id: user.id})
  end

  def has_unread_comments?(user)
    unread_comments_for(user).present?
  end

  def read_by(user)
    destroyed = false
    unread = self.unread_for(user)
    if unread
      unread.destroy()
      destroyed = true
    end
    comment_unreads = Unread.where(resource: self.unread_comments_for(user))
    if comment_unreads.present?
      comment_unreads.destroy_all()
      destroyed = true
    end
    destroyed
  end

  def notification_emails
    User.where(mail_notification: true).where.not(id: self.user.id).pluck(:email)
  end

  private
  def create_unreads
    User.where.not(id: self.user_id).each do |user|
      self.unreads.create(user: user)
    end
  end
end
