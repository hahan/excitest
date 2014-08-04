class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new (user_params)
    if @user.save
      sign_in @user
      flash[:success]="Welcome to Excitest"
      redirect_to @user
    else
      render "new"
    end
  end

  def destroy
    User.friendly.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def show
    @user = User.friendly.find(params[:id])
    @user_cards = @user.user_cards.paginate(page: params[:page], :per_page => 10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def correct_user
    @user = User.friendly.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) or current_user.admin?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
