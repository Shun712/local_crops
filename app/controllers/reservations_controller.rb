class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.includes(:user, :crop)
                               .where("user_id = ? or crop_id = ?", current_user.id, current_user.crops.ids)
                               .sorted
                               .page(params[:page])
                               .per(12)
  end

  def new
    @crop = Crop.find(params[:crop_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.save
    redirect_to root_path, success: '予約を登録しました'
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy!
    redirect_to reservations_path, success: '予約を取消しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:received_at).merge(crop_id: params[:crop_id])
  end
end
