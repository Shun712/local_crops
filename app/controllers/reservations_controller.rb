class ReservationsController < ApplicationController
  def new
    @crop = Crop.find(params[:crop_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to crops_path, success: '作物を予約しました'
    else
      flash.now[:danger] = '作物の予約に失敗しました'
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy!
    redirect_to reservations_path, success: '予約を削除しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:received_at)
  end
end
