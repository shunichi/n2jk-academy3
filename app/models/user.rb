class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true

  serialize :auth_hash, JSON

  scope :write_some_post, -> { where(id: Post.pluck(:user_id).uniq) }

  def self.create_by_github(auth)
    User.create!(
        github_id: auth[:uid],
        name: auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login],
        email: auth[:info][:email],
        image: auth[:info][:image],
        auth_hash: auth,
        mail_notification: true,
        posts_updated_at: Time.now
        )
  end

  def has_unreads_for(other_user)
    self.posts.joins(:unreads).where(unreads: {user_id: other_user.id}).present? ||
      self.posts.joins(comments: :unreads).where(unreads: {user_id: other_user.id}).present?
  end
end
