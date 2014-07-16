class StaticPagesController < ApplicationController

  def home
    @user = User.new
    home_page_user = User.find_by( email: 'homepage@excitest.com' )
    if ( !home_page_user.nil?)
    	@user_cards = home_page_user.user_cards.paginate( page: params[:page], :per_page => 10 )
     end	
  end

  def about
  end
end
