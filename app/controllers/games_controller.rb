class GamesController < ApplicationController
  before_action :authenticate
  before_action :set_team
  before_action :set_game , except: [:index, :new, :create]
  before_action :if_not_admin, except: [:index, :show]

  def index
    @games = Game.where(team_id: @team.id)
  end

  def new
    @game = Game.new
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
    @members = GamesUser.eager_load(:user, :status).where(game_id: @game.id)
    # 参加表明しているメンバーを抽出(配列)
    @going_members = @members.select{ |a| a.status_id == 2}
    # ログインユーザーの出欠情報取得(配列)
    @games_user = @members.select{ |a| a.user_id == current_user.id}
  end

  def edit
  end

  def update
    @game.update(game_params)
    redirect_to team_game_path(@team.id, @game.id)
  end

  def destroy
    @game.destroy
    flash[:success] = "試合が削除されました"
    redirect_to main_team_path(@team.id)
  end

  def send_remind
    @members = @team.users
    @members.each do |member|
      @game.create_notification_remind_game(current_user, member.id)
    end
    flash[:success] = "通知を送りました"
    redirect_to team_game_path(@team.id, @game.id)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def game_params
    params.require(:game).permit(:opponent, :time, :date, :begin_time, :finish_time, :place)
  end
end
