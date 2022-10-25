class RoomChannel < ApplicationCable::Channel
  before_subscribe :set_room

  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end
