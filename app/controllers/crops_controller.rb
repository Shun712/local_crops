class CropsController < ApplicationController
  def index
    if params[:q]
      sorted_crops = @q.result(distinct: true)
                       .harvested_within_a_week
                       .not_reserved
                       .select do |crop|
        current_user.distance_within_5km?(crop)
      end
      @crops = Crop.where(id: sorted_crops.map { |crop| crop.id })
                   .includes(user: {avatar_attachment: :blob })
                   .page(params[:page])
                   .per(12)
    else
      # 収穫1週間以内、未予約、距離5km以内の作物を取得
      local_crops = Crop.harvested_within_a_week.not_reserved.select do |crop|
        current_user.distance_within_5km?(crop)
      end
      @crops = Crop.where(id: local_crops.map { |crop| crop.id })
                   .includes(user: {avatar_attachment: :blob })
                   .sorted
                   .page(params[:page])
                   .per(12)
    end
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

  def search
    searched_crops = @q.result(distinct: true)
                       .harvested_within_a_week
                       .not_reserved
                       .select do |crop|
      current_user.distance_within_5km?(crop)
    end
    @crops = Crop.where(id: searched_crops.map { |crop| crop.id })
                 .includes(user: {avatar_attachment: :blob })
                 .page(params[:page])
                 .per(12)
  end

  private

  def crop_params
    params.require(:crop).permit(:name, :description, :harvested_on, :picture)
  end
end
