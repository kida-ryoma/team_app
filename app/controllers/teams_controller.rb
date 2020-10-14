class TeamsController < ApplicationController
  before_action :authenticate, except: [:add_user, :new, :create]
  before_action :set_user
  before_action :set_team, except: [:new, :create]
  before_action :if_not_admin ,only: [:edit, :put_mail, :send_mail, :update]

  def main
    #今日以降で直近のGameレコードを一つ取得
    @latest_game = Game.where('team_id = ? and date >= ? ', @team.id, Date.today).order(date: "ASC").limit(1)[0]
    @games = @team.games
  end

  def new
    @team = Team.new
  end

  def create
    if  @team = Team.create(team_params)
      session["team"] = @team.attributes
      redirect_to users_registrations_admin_signup_path
    else
      redirect_to root_path
    end
  end

  def show
    @members = User.where(team_id: @team.id)
  end

  def edit
  end

  def put_mail
    @email = Email.new
  end

  def send_mail
    @email = Email.create(email_params)
    unless @email.valid?
      flash.now[:alert] = @email.errors.full_messages
      render :put_mail and return
    end
    RegistrationMailer.registration_mail(@team,@email).deliver_now
    redirect_to main_team_path(@team.id)
  end

  def add_user
    @user = User.new
  end

  def create_user
    @user = User.create(user_params)
    @user.update(team_id: @team.id)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :add_user and return
    end
    sign_in(:user, @user)
    redirect_to main_team_path(@team.id)
  end

  def update
    @team.update(team_params)
    unless @team.valid?
      flash.now[:alert] = @team.errors.full_messages
      render :edit and return
    end
    redirect_to main_team_path(@team)
  end


  private

  def team_params
    params.require(:team).permit(:name, :image)
  end

  def set_team
    @team = Team.find(params[:id])

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
