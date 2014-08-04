class PasswordResetsController < ApplicationController
  def create
  	user = User.find_by_email(params[:session][:email])
  	user.send_password_reset if user
  	flash.now[:error] = "Email sent with password reset instructions."
    render "new"
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
    	redirect_to new_password_reset_path, :alert => "Password &crarr; 
      	reset has expired."
  	elsif @user.update_attributes(user_params)    	
    	flash.now[:success] = "Password has been reset. Please login using new password."
    	redirect_to new_session_path, :alert => "Password has been reset. Please login using new password."
  	else
    	render :edit
  	end
 end

  def user_params
    params.require(:user).permit(:password,
                                 :password_confirmation)
  end
end
