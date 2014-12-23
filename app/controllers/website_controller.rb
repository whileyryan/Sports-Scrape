class WebsiteController < ApplicationController
  def index
    @websites = Website.order(created_at: :desc)
  end

  def show_web
    Website.get_user_websites(params['website'])
    redirect_to '/'
  end
end
