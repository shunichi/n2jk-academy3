class Comment < ActiveRecord::Base
  has_many :unreads, dependent: :destroy, as: :resource
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  after_create :create_unreads

  def not_read_yet?(user)
    self.unreads.where(user_id: user.id).present?
  end

  def notification_emails
    emails = self.post.comments.joins(:user).where(users: {mail_notification: true}).where.not(users: {id: self.user.id}).pluck(:email)
    emails.push(self.post.user.email) unless self.user == self.post.user
    emails.uniq
  end

  private
  def create_unreads
    User.where.not(id: self.user_id).each do |user|
      self.unreads.create(user: user)
    end
  end
end
