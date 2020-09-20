class UsersController < ApplicationController
  before_action :set_team
  def show
  end


  private

  def set_team
    @team = Team.find(current_user.team_id)
  end
end
