class ProfessionalsController < ApplicationController
  before_filter :find_professional, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @professional.update_attributes(params[:professional])
      flash[:notice] = "Profile has been updated"
      redirect_to professional_path(@professional)
    else
      flash[:alert] = "Profile has not been updated"
      render :action => "edit"
    end
  end

  private

  def find_professional
    @professional = User.find(params[:id])
  end
end
