class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    @team.update(user_id: current_user.id)
    redirect_to root_path
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit

  end

  def update
  end


  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_user 
    @user = current_user
  end
end
