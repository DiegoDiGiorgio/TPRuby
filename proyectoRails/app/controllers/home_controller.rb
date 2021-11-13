class HomeController < ApplicationController
  def index
  end

  def export
    @appointments = Appointment.all
  end


end
