class UserCardsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [ :destroy ]

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

  def update
    @user_card =  current_user.user_cards.find( params[:id] )

    if @user_card.update_attributes( user_card_params )
      #Find the entry to be deleted, its the one that comes in with :id but no entry key or value
      user_card_entries_attributes = user_card_params[:user_card_entries_attributes ]
      user_card_entries_attributes.each do |index, values|
        if not values[:entry_key]
          @user_card.user_card_entries.destroy(values[:id])
        end
      end

      flash[:success] = "Card updated"
      redirect_to @user_card
    else
      render 'edit'
    end
  end

  def search
    if params[:search].nil?
      return nil
    end

    if params[:search][:search_term].nil?
      return nil
    end

    if params[:search][:search_term].blank?
      return nil
    end

    @user_cards =  UserCard.where("name LIKE ? or description LIKE ?", "%#{params[:search][:search_term]}%", "%#{params[:search][:search_term]}%").paginate(page: params[:page], :per_page => 5)
  end

  def delete
    if current_user.admin?
      @user_card =  UserCard.find( params[:id] )
    else
      @user_card =  current_user.user_cards.find( params[:id] )
    end
    if @user_card.destroy
      flash[:success] = "Card deleted"
      redirect_to current_user
    end
  end


  def public_card
    @user_card =  UserCard.find( params[:id] )
    @user_card_entries = @user_card.user_card_entries.paginate(page: params[:page], :per_page => 10)
    render "show"
  end

  def show
    if current_user.admin?
      public_card
    else
      @user_card =  current_user.user_cards.find( params[:id] )
      @user_card_entries = @user_card.user_card_entries.paginate(page: params[:page], :per_page => 10)
    end
  end

  def flash_cards
    if current_user.admin?
      public_card
    else
      @user_card =  current_user.user_cards.find( params[:id] )
      @user_card_entries = @user_card.user_card_entries.paginate(page: params[:page], :per_page => 1)
    end
  end

  def edit
    if current_user.admin?
      @user_card =  UserCard.find( params[:id] )
      @user_card_entries = @user_card.user_card_entries.all
    else
      @user_card =  current_user.user_cards.find( params[:id] )
      @user_card_entries = @user_card.user_card_entries.all
    end
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
