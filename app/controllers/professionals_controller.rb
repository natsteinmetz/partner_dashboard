class ProfessionalsController < ApplicationController
  before_filter :find_professional, only: [:show, :edit, :update]

  def index
    @professionals = Professional.includes(:partners).all
  end

  def show
  end

  def edit
  end

  def update
  end

private
  def find_professional
    @professional = Professional.find(params[:id])
  end

end
