class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    binding.pry
  end
end
