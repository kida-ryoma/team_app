class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    redirect_to root_path
  end
end
