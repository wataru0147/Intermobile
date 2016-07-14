class CarsController < ApplicationController
  #do not show cars unless the user is authenticated or logged in
  before_action :authenticate_user!
  


  def index
  end
end
