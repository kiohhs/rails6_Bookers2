class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def is_favorite?(user)
    self.favorites.any? { |favorite| favorite.user_id == user.id }
  end
end
