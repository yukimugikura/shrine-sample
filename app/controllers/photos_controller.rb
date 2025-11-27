class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    
    if @photo.save
      # Derivatives（サムネイル）を生成
      @photo.image_attacher.create_derivatives
      @photo.save
      
      redirect_to @photo, notice: "Photo was successfully uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
