class GamesController < ApplicationController
  before_action :authenticate
  before_action :set_team
  before_action :if_not_admin, except: [:index, :show]

  def index
    @games = Game.where(team_id: @team.id)
  end

  def new
    @game = Game.new
    @users = User.where(team_id: @team.id)
  end

  def create
    @game = Game.create(game_params)
    @game.update(team_id: @team.id)
    unless @game.valid?
      flash.now[:alert] = @game.errors.full_messages
      render :new and return
    end
    flash[:success] = "試合を追加しました"
    users = User.where(team_id: @team.id) 
    users.each do |user|
      GamesUser.create(user_id: user.id, game_id: @game.id)
      @game.create_notification_new_game!(current_user, user.id)
    end
    redirect_to main_team_path(@team.id)
  end

  def show
    @game = Game.find(params[:id])
    @members = GamesUser.eager_load(:user, :status).where(game_id: @game.id)
    @going_members = GamesUser.where('game_id = ? and status_id = ?', @game.id, 2) 
  end

  def edit
  end

  def update
  end

  def send_remind
    @game = Game.find(params[:id])
    @members = @team.users
    @members.each do |member|
      @game.create_notification_remind_event(current_user, member.id)
    end
    flash[:success] = "通知を送りました"
    redirect_to team_game_path(@team.id, @game.id)
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def game_params
    params.require(:game).permit(:opponent, :time, :date, :begin_time, :finish_time, :place)
  end
end
