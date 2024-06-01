class ChatRoom < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
end
