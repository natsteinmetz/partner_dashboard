class PartnersController < ApplicationController
  def index
    @partners = Partner.all
  end
end
