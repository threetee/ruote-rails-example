class AccountApplicationFormsController < ApplicationController
  def index
    @account_application_forms = AccountApplicationForm.all
  end
  
  def show
    @account_application_form = AccountApplicationForm.find(params[:id])
  end
  
  def new
    @account_application_form = AccountApplicationForm.new
  end
  
  def create
    @account_application_form = AccountApplicationForm.new(params[:account_application_form])
    if @account_application_form.save
      flash[:notice] = "Successfully created account application form."
      redirect_to @account_application_form
    else
      render :action => 'new'
    end
  end
  
  def edit
    @account_application_form = AccountApplicationForm.find(params[:id])
  end
  
  def update
    @account_application_form = AccountApplicationForm.find(params[:id])
    if @account_application_form.update_attributes(params[:account_application_form])
      flash[:notice] = "Successfully updated account application form."
      redirect_to @account_application_form
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @account_application_form = AccountApplicationForm.find(params[:id])
    @account_application_form.destroy
    flash[:notice] = "Successfully destroyed account application form."
    redirect_to account_application_forms_url
  end
end
