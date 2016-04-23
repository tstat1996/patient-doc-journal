# Controls sessions for patients
class PatientSessionsController < ApplicationController
  def new
  end

  def create
    @patient = Patient.find_by(email: params[:email])
    if !@patient.nil? && @patient.password == params[:password]
      session[:patient_id] = @patient.id
      redirect_to("/patients/#{@patient.id}")
    else
      redirect_to '/plogin'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
