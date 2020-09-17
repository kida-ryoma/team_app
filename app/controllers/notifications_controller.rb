class NotificationsController < ApplicationController
  before_action :set_team
  def index
    @all_notifications = current_user.passive_notifications
    @all_notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
