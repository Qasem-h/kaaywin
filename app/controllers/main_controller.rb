class MainController < ApplicationController
 

  def index #the method that is called for front office and is the application root page
  	@front_office = true
  end
end
