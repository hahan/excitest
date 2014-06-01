class UserCardsController < ApplicationController
  def new
    @user_card = UserCard.new
    3.times { @user_card.user_card_entries.build}
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
    params.require(:user_card).permit(:name, :description, user_card_entries_attributes: [:id, :entry_key, :entry_value])
  end
end
