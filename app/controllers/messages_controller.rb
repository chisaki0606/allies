class MessagesController < ApplicationController
  before_action :authenticate_user
  def show
    @user = User.find(params[:id])
    rooms = @current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create([{:user_id => @current_user.id, :room_id => @room.id}, {:user_id => @user.id, :room_id => @room.id}])
    end
    @messages = @room.messages.order(created_at: :desc)
    @message = Message.new(room_id: @room.id)
    render("users/message_form")
  end
  def create
    @message = @current_user.messages.new(message_params)
    if @message.save
      redirect_to request.referer
    else
      flash[:danger] = @message.errors.full_messages
      redirect_to request.referer
    end
  end
  private
  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end