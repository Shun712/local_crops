class CropsController < ApplicationController
  def index
    @crops = Crop.harvested_within_a_week
                 .includes(:user)
                 .page(params[:page])
                 .per(12)
  end

  def new
    @crop = Crop.new
  end

  def create
    @crop = current_user.crops.build(crop_params)
    if @crop.save
      redirect_to crops_path, success: '作物を登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @crop = Crop.find(params[:id])
  end

  def edit
    @crop = current_user.crops.find(params[:id])
  end

  def update
    @crop = current_user.crops.find(params[:id])
    if @crop.update(crop_params)
      redirect_to crops_path, success: '作物を更新しました'
    else
      flash.now[:danger] = '作物の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @crop = current_user.crops.find(params[:id])
    @crop.destroy!
    redirect_to crops_path, success: '作物を削除しました'
  end

  private

  def crop_params
    params.require(:crop).permit(:name, :description, :harvested_on, :picture)
  end
end
