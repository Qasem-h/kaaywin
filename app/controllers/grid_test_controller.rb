class GridTestController < ApplicationController
  def test
  	@front_office = true
  	@leagues = League.all
  	session[:betSlip] = nil
  end
end
