class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    $current_user_role = current_user.roles
  end
end
