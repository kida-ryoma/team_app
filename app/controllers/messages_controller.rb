class MessagesController < ApplicationController
  def create
    @dm = current_user.messages.new(dm_params)
    if @dm.save
      @dm.create_notification_dm(current_user, session[:user_id])
      redirect_to room_path(params[:room_id])
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def dm_params
    params.require(:message).permit(:content, :room_id)
  end
end
