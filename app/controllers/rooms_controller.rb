class RoomsController < ApplicationController

  def index
    @rooms = Room.ordered
  end


  def new
    @room = Room.new
  end


  def create
  @room = Room.new(room_params)

  if @room.save
    redirect_to "/rooms"
  else
    render :new, status: :unprocessable_entity
  end
end

def edit
  @room = Room.find(params[:id])
end


def update
  @room = Room.find(params[:id])

  if @room.update(room_params)
    redirect_to "/rooms"
  else
    render :edit, status: :unprocessable_entity
  end
end


def destroy
  @room = Room.find(params[:id])
  @room.destroy

  redirect_to "/rooms"
end


  def room_params
    params.require(:room).permit(
      :room_number,
      :floor,
      :room_type,
      :rent,
      :status
    )
  end


  





end
