class Comment < ActiveRecord::Base
  has_many :unreads, dependent: :destroy, as: :resource
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  after_create :create_unreads

  def not_read_yet?(user)
    self.unreads.where(user_id: user.id).present?
  end

  private
  def create_unreads
    User.where.not(id: self.user_id).each do |user|
      self.unreads.create(user: user)
    end
  end
end
