class PatientesController < ApplicationController
  before_action :set_patiente, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /patientes or /patientes.json
  def index
    @patientes = Patiente.all
  end

  # GET /patientes/1 or /patientes/1.json
  def show
  end

  # GET /patientes/new
  def new
    @patiente = Patiente.new
  end

  # GET /patientes/1/edit
  def edit
  end

  # POST /patientes or /patientes.json
  def create
    @patiente = Patiente.new(patiente_params)

      respond_to do |format|
        if @patiente.save
          format.html { redirect_to @patiente, notice: "Patiente was successfully created." }
          format.json { render :show, status: :created, location: @patiente }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @patiente.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /patientes/1 or /patientes/1.json
  def update
    respond_to do |format|
      if @patiente.update(patiente_params)
        format.html { redirect_to @patiente, notice: "Patiente was successfully updated." }
        format.json { render :show, status: :ok, location: @patiente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patiente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patientes/1 or /patientes/1.json
  def destroy
    @patiente.destroy
    respond_to do |format|
      format.html { redirect_to patientes_url, notice: "Patiente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patiente
      @patiente = Patiente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patiente_params
      params.require(:patiente).permit(:name, :surname, :phone)
    end
end
