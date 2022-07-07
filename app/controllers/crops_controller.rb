class CropsController < ApplicationController
  def index
    if params[:near]
      crops = Crop.within_distance(current_user)
                  .sort_by { |crop| crop.user.distance_to(current_user.position) }
      crop_ids = crops.pluck(:id)
    elsif params[:far]
      crops = Crop.within_distance(current_user)
                  .sort_by { |crop| crop.user.distance_to(current_user.position) }
      crop_ids = crops.pluck(:id).reverse
    elsif params[:new]
      crops = Crop.within_distance(current_user)
                  .sorted
      crop_ids = crops.pluck(:id)
    elsif params[:old]
      crops = Crop.within_distance(current_user)
                  .reverse_sorted
      crop_ids = crops.pluck(:id)
    else
      # 収穫1週間以内、未予約、距離5km以内の作物を取得
      crops = Crop.within_distance(current_user)
                  .sorted
      crop_ids = crops.pluck(:id)
    end
    @crops = Crop.where(id: crop_ids)
                 .order_as_specified(id: crop_ids)
                 .with_attached_picture
                 .includes(user: { avatar_attachment: :blob })
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

  def search
    @crops = @q.result(distinct: true)
               .within(5, origin: current_user.position)
               .with_attached_picture
               .includes(user: { avatar_attachment: :blob })
               .harvested_within_a_week
               .not_reserved
               .page(params[:page])
               .per(12)
  end

  private

  def crop_params
    params.require(:crop).permit(:name, :description, :harvested_on, :picture)
  end
end
