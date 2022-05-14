class ReservationsController < ApplicationController
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
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy!
    redirect_to root_path, success: '予約を削除しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:received_at).merge(crop_id: params[:crop_id])
  end
end
