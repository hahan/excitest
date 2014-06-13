class UserCardsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @user_card = UserCard.new
    2.times { @user_card.user_card_entries.build}
  end

  def create
    @user_card = current_user.user_cards.build( user_card_params )
    if @user_card.save
      redirect_to @user_card
    else
      render "new"
    end
  end

  def public_card
    @user_card =  UserCard.find( params[:id] )
    @user_card_entries = @user_card.user_card_entries.paginate(page: params[:page], :per_page => 1)
    render "show"
  end

  def show
    @user_card =  current_user.user_cards.find( params[:id] )
    @user_card_entries = @user_card.user_card_entries.paginate(page: params[:page], :per_page => 1)
  end

  private

  def user_card_params
    params.require(:user_card).permit(:name, :description, user_card_entries_attributes: [:id, :entry_key, :entry_value])
  end

   def correct_user
      @user_card = current_user.user_cards.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
   end
end
