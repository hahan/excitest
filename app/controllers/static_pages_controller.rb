class StaticPagesController < ApplicationController


  def home
    @user_cards = UserCard.paginate(page: params[:page], :per_page => 10)
  end

  def about
  end
end
