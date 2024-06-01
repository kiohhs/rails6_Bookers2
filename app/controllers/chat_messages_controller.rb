class ChatMessagesController < ApplicationController
  def create
    @chat_message = current_user.chat_messages.build(chat_params)
    @chat_message.save
  end

  private

  def chat_params
    params.require(:chat_message).permit(:message, :chat_room_id)
  end
end
