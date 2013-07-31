class PartnersController < ApplicationController
  before_filter :find_partner, only: [:show, :edit, :update]

  def index
    @partners = Partner.all
  end

  def show    
  end

  def edit
  end

  def update
    if @partner.update_attributes(params[:partner])
      flash[:notice] = "Information has been updated."
      redirect_to @partner
    else
      flash[:alert] = "Information has not been updated."
      render action: "edit"
    end
  end

private
  def find_partner
    @partner = Partner.find(params[:id])
  end
end
