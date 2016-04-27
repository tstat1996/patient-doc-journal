class DoctorSessionsController < ApplicationController
  def new
  end

  def create
    @doctor = Doctor.find_by(email: params[:email])
    if !@doctor.nil? && @doctor.password == params[:password]
      session[:doctor_id] = @doctor.id
      redirect_to("/doctors/#{@doctor.id}")
    else
      redirect_to '/dlogin'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
