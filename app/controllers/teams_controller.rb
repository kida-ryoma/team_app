class TeamsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_user
  before_action :if_not_admin ,only: [:edit, :put_mail, :send_mail, :update]

  def main
    @team = Team.find(params[:id])
    #今日以降で直近のGameレコードを一つ取得
    @latest_game = Game.where('team_id = ? and date >= ? ', @team.id, Date.today).order(date: "ASC").limit(1)[0]
    # binding.pry
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    session["team"] = @team.attributes
    redirect_to users_registrations_admin_signup_path
  end

  def show
    @team = Team.find(params[:id])
    @members = User.where(team_id: @team.id)
  end

  def edit
    @team = Team.find(params[:id])
  end

  def put_mail
    @team = Team.find(params[:id])
    @email = Email.new
  end

  def send_mail
    @email = Email.create(email_params)
    @team = Team.find(params[:id])
    RegistrationMailer.registration_mail(@team,@email).deliver_now
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
    sign_in(:user, @user)
    redirect_to main_team_path(@team.id)
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)
    redirect_to main_team_path(@team)
  end


  private

  def team_params
    params.require(:team).permit(:name, :image)
  end

  def set_user 
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def email_params
    params.require(:email).permit(:email)
  end
end
