class UserCardsController < ApplicationController
  def new
    @user_card = UserCard.new
  end

  def create
    @user_card = UserCard.new( user_card_params )
    if @user_card.save
      redirect_to @user_card
    else
      render "new"
    end
  end

  def show
    @user_card = UserCard.find( params[:id] )
  end

  private

  def user_card_params
    params.require(:user_card).permit(:name, :description)
  end
end
