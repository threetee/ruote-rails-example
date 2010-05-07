class NdasController < ApplicationController
  def index
    @ndas = Nda.all
  end
  
  def show
    @nda = Nda.find(params[:id])
  end
  
  def new
    @nda = Nda.new
  end
  
  def create
    @nda = Nda.new(params[:nda])
    if @nda.save
      flash[:notice] = "Successfully created nda."
      redirect_to @nda
    else
      render :action => 'new'
    end
  end
  
  def edit
    @nda = Nda.find(params[:id])
  end
  
  def update
    @nda = Nda.find(params[:id])
    if @nda.update_attributes(params[:nda])
      flash[:notice] = "Successfully updated nda."
      redirect_to @nda
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @nda = Nda.find(params[:id])
    @nda.destroy
    flash[:notice] = "Successfully destroyed nda."
    redirect_to ndas_url
  end
end
