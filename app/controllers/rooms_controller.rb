class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @room = Room.new
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    unless @room.player_exist? cookies[:uuid]
      @room.players << cookies[:uuid]
      @room.save
    end

    @disabled = @room.is_played?(cookies[:uuid]) ? "disabled" : ""
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: "Room was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    @room.update_board(update_params)
    ActionCable.server.broadcast "room_channel_#{@room.slug}",
      { room: @room, playerId: cookies[:uuid], won: @room.won? }

    @room.clear if @room.won?

    respond_to do |format|
      format.json { render :update }
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :slug)
  end

  def update_params
    params.require(:room).permit(:index, :current)
  end
end
