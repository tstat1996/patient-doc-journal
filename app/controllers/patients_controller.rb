class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :adddoc, :doctors, :adddoctor, :journals]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
  end

  def doctors
    @doctors = @patient.doctors
  end

  def journals
    @journals = @patient.journals
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    @patient.password = patient_params[:password]
    respond_to do |format|
      if @patient.save
        session[:patient_id] = @patient.id
        format.html { redirect_to @patient, notice: 'Welcome new patient.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient destroyed.' }
      format.json { head :no_content }
    end
  end

  def adddoc
  end

  def adddoctor
    respond_to do |format|
      if @patient.add_doctor(params[:patient][:doctor][:code])
        format.html { redirect_to @patient, notice: 'Doctor added.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :adddoc }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def patient_params
    params.require(:patient).permit(:name, :email, :password)
  end
end
