class Admin::RelationshipsController < Admin::BaseController
  def index
    @relationships = Relationship.all
  end

  def new
  end

  def create
  end

  def update
    #Get Relationship
    @relationship = Relationship.find(params[:id])
    @relationship.update_attribute(:connected, true)
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { head :no_content }
    end
  end
end