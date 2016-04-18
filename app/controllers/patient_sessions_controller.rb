class PatientSessionsController < ApplicationController
  def new
  end

  def create
    @patient = Patient.find_by(name: params[:name])
    if !@patient.nil? && @patient.password_hash == params[:password]
      session[:patient_id] = @patient_id
      redirect_to("/patients/#{@patient.id}")
    else
      redirect_to patients_login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
