class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[ show edit update destroy ]

  # GET /professionals or /professionals.json
  def index   
      @professionals = Professional.all
  end

  # GET /professionals/1 or /professionals/1.json
  def show
  end

  # GET /professionals/new
  def new
    if($current_user_role=='administrador')
      @professional = Professional.new
    else
      redirect_to '/home', flash: {notice: "you need to be admin in order to create a professional"}
    end
  end

  # GET /professionals/1/edit
  def edit
    if($current_user_role=='administrador')

    else
      redirect_to '/home', flash: {notice: "you need to be admin in order to create a professional"}
    end
  end

  # POST /professionals or /professionals.json
  def create
    if($current_user_role=='administrador')
      @professional = Professional.new(professional_params)
        respond_to do |format|
          if @professional.save
            format.html { redirect_to @professional, notice: "Professional was successfully created." }
            format.json { render :show, status: :created, location: @professional }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @professional.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to '/home', flash: {notice: "you need to be admin in order to create a professional"}
      end
  end

  # PATCH/PUT /professionals/1 or /professionals/1.json
  def update
    if($current_user_role=='administrador')
      respond_to do |format|
        if @professional.update(professional_params)
          format.html { redirect_to @professional, notice: "Professional was successfully updated." }
          format.json { render :show, status: :ok, location: @professional }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @professional.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/home', flash: {notice: "you need to be admin in order to update a professional"}
    end
  end

  # DELETE /professionals/1 or /professionals/1.json
  def destroy
    if($current_user_role=='administrador')
      @professional.destroy
      respond_to do |format|
        format.html { redirect_to professionals_url, notice: "Professional was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to '/home', flash: {notice: "you need to be admin in order to delete a professional"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def professional_params
      params.require(:professional).permit(:name, :surname)
    end
end
