class ChatRoomsController < ApplicationController
  before_action :block_no_follow_each_other, only: [:show]

  def show
    @user = User.find(params[:id])
    chat_room_ids = current_user.entries.pluck(:chat_room_id)
    entries = Entry.find_by(user_id: @user.id, chat_room_id: chat_room_ids)
    if entries.nil?
      @chat_room = ChatRoom.new
      @chat_room.save
      Entry.create(user_id: current_user.id, chat_room_id: @chat_room.id)
      Entry.create(user_id: @user.id, chat_room_id: @chat_room.id)
    else
      @chat_room = entries.chat_room
    end
    @chat_messages = @chat_room.chat_messages
    @chat_message = ChatMessage.new(chat_room_id: @chat_room.id)
  end

  private

  def block_no_follow_each_other
    user = User.find(params[:id])
    unless current_user != user && current_user.follow_each_other?(user)
      redirect_to user
    end
  end
end
