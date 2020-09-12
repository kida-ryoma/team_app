class TeamsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user

  def main
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    @team.update(admin_user_id: current_user.id)
    @user.update(team_id: @team.id)
    redirect_to main_team_path(@team)
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def send_mail
    @team = Team.find(params[:id])
    RegistrationMailer.registration_mail(@team).deliver_now
    redirect_to main_team_path(@team.id)
  end

  def add_user
    @team = Team.find(params[:id])
    @user = User.new 
  end

  def create_user
    @team = Team.find(params[:id])
    @user = User.create(user_params)
    @user.update(team_id: @team.id)
    redirect_to main_team_path(@team.id)
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)
    redirect_to main_team_path(@team)
  end


  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_user 
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
