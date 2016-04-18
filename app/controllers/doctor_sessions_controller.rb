class DoctorSessionsController < ApplicationController
  def new
  end

  def create
    @doctor = Doctor.find_by(name: params[:name])
    if !@doctor.nil? && @doctor.password_hash == params[:password]
      session[:doctor_id] = @doctor.id
      redirect_to("/doctors/#{@doctor.id}")
    else
      redirect_to doctors_login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end