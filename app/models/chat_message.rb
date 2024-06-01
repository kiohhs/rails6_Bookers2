class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :message, presence: true, length: { maximum: 140 }
end
