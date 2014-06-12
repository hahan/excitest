class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
  	@user = User.new ( user_params )
  	if @user.save
      sign_in @user
  		flash[:success]="Welcome to Excitest"
  		redirect_to @user
  	else
  		render "new"
  	end 	
  end

  def show
   	@user = User.find( params[:id] ) 
    @user_cards = @user.user_cards.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
