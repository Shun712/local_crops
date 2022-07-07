class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :address_empty

  def top; end

  def about; end

  def terms; end

  def privacy; end
end
