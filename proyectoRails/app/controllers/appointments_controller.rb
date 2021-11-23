class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
    @patientes = Patiente.all
    @professionals = Professional.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new

  def new
    if($current_user_role!='consulta')
      @patientes = Patiente.all
      @professionals = Professional.all
      @appointment = Appointment.new
    else
      redirect_to '/home', flash: {notice: "you need to be admin or assistant in order to create an appointment"}
    end
  end

  # GET /appointments/1/edit
  def edit
    if($current_user_role!='consulta')
      @patientes = Patiente.all
      @professionals = Professional.all
    else
      redirect_to '/home', flash: {notice: "you need to be admin or assistant in order to edit an appointment"}
    end
  end

  # POST /appointments or /appointments.json
  def create
    if($current_user_role!='consulta')
      @appointment = Appointment.new(appointment_params)
      @patientes = Patiente.all
      @professionals = Professional.all
        respond_to do |format|
          if @appointment.save
            format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
            format.json { render :show, status: :created, location: @appointment }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to '/home', flash: {notice: "you need to be admin or assistant in order to create an appointment"}
      end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    if($current_user_role!='consulta')
      @patientes = Patiente.all
      @professionals = Professional.all
      respond_to do |format|
        if @appointment.update(appointment_params)
          format.html { redirect_to @appointment, notice: "Appointment was successfully updated." }
          format.json { render :show, status: :ok, location: @appointment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/home', flash: {notice: "you need to be admin or assistant in order to update an appointment"}
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    if($current_user_role!='consulta')
      @appointment.destroy
      respond_to do |format|
        format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to '/home', flash: {notice: "you need to be admin or assistant in order to delete an appointment"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date, :patiente_id, :professional_id, :notes)
    end
end
