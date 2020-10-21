class RoomsController < ApplicationController
  before_action :set_team

  def index
    @members = @team.users
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entry = Entry.find_by(user_id: @user.id, room_id: rooms)
    if entry.nil?
      @room = Room.create
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
    else
      @room = entry.room
    end
    @dm = Message.new(room_id: @room.id)
    @dms = @room.messages
    session[:user_id] = @user.id
  end

  private

  def set_team
    @team = Team.find(current_user.team_id)
  end
end
