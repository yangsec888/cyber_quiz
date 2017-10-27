class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy, :crop, :cropped_image, :remove_logo]

  # GET /trainers
  # GET /trainers.json
  def index
    @trainers = Trainer.all
  end

  # GET /trainers/1
  # GET /trainers/1.json
  def show
  end

  # GET /trainers/new
  def new
    @trainer = Trainer.new
  end

  # GET /trainers/1/edit
  def edit
  end

  # POST /trainers
  # POST /trainers.json
  def create
    @trainer = Trainer.new(trainer_params)

    respond_to do |format|
      if @trainer.save
        format.html { redirect_to @trainer, notice: 'Trainer was successfully created.' }
        format.json { render :show, status: :created, location: @trainer }
      else
        format.html { render :new }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainers/1
  # PATCH/PUT /trainers/1.json
  def update
    respond_to do |format|
      if trainer_params[:logo].nil?
        if @trainer.update(trainer_params)
          format.html { redirect_to @trainer, notice: 'Trainer was successfully updated.' }
          format.json { render :show, status: :ok, location: @trainer }
        else
          format.html { render :edit }
          format.json { render json: @trainer.errors, status: :unprocessable_entity }
        end
      else
        if @trainer.update(trainer_params)
          format.html { redirect_to :back, notice: 'Trainer was successfully updated.' }
          format.json { render :show, status: :ok, location: @trainer }
        else
          format.html { render :edit }
          format.json { render json: @trainer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /trainers/1
  # DELETE /trainers/1.json
  def destroy
    @trainer.destroy
    respond_to do |format|
      format.html { redirect_to trainers_url, notice: 'Trainer was successfully destroyed.' }
      format.json { head :no_content }
    end
    FileUtils.rm('public/uploads/trainer/logo_crop.png') if File.exist?('public/uploads/trainer/logo_crop.png')
  end

  def logo
    @trainer = Trainer.first
    if @trainer.nil?
      redirect_to new_trainer_path, notice: 'Please create a trainer first.'
    end
  end

  def crop
    @path1 = File.join Rails.root, 'public/uploads/trainer/logo.png'
    @path2 = File.join Rails.root, 'public/uploads/trainer/logo_crop.png'
    FileUtils.cp @path1, @path2
  end

  def cropped_image
    image = MiniMagick::Image.open(params[:path])
    crop_params = "#{params[:trainer][:crop_w]}x#{params[:trainer][:crop_h]}+#{params[:trainer][:crop_x]}+#{params[:trainer][:crop_y]}"
    image.crop(crop_params)
    image.write (params[:path])
    redirect_to trainers_logo_path
  end

  def remove_logo
    @trainer.remove_logo!
    @trainer.save
    FileUtils.rm('public/uploads/trainer/logo_crop.png') if File.exists?('public/uploads/trainer/logo_crop.png')
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainer
      @trainer = Trainer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainer_params
      params.require(:trainer).permit(:name, :email, :phone, :description, :logo)
    end
end
