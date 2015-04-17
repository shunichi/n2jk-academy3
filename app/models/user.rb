class User < ActiveRecord::Base
  has_many :posts

  serialize :auth_hash, JSON

  def self.create_by_github(auth)
    User.create!(
        github_id: auth[:uid],
        name: auth[:info][:name] || auth[:info][:nickname],
        email: auth[:info][:email],
        image: auth[:info][:image],
        auth_hash: auth,
        mail_notification: true,
        posts_updated_at: Time.now
        )
  end
end
