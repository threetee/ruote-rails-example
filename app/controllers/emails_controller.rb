class EmailsController < ApplicationController
  # GET /emails
  # GET /emails.xml
  def index
    @emails = Email.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emails }
    end
  end

  # GET /emails/1
  # GET /emails/1.xml
  def show
    @email = Email.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.xml
  def new
    @email = Email.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @email }
    end
  end

  # GET /emails/1/edit
  def edit
    @email = Email.find(params[:id])
  end

  # POST /emails
  # POST /emails.xml
  def create
    @email = Email.new(params[:email])

    respond_to do |format|
      if @email.save
        @email.ruote_create_email
        flash[:notice] = 'Email was successfully created.'
        format.html { redirect_to(@email) }
        format.xml  { render :xml => @email, :status => :created, :location => @email }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @email.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /emails/1
  # PUT /emails/1.xml
  def update
    @email = Email.find(params[:id])
    if ( fei = Ruote::FlowExpressionId.from_id(params[:email][:fei_id]) )
      workitem = RuoteKit.storage_participant[fei]
    end

    respond_to do |format|
      if @email.update_attributes(params[:email])
        RuoteKit.storage_participant.reply(workitem)
        flash[:notice] = 'Email was successfully updated.'
        format.html { redirect_to(@email) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @email.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def accept_forms
    @email = Email.find(params[:id])
    if ( fei = Ruote::FlowExpressionId.from_id(params[:email][:fei_id]) )
      workitem = RuoteKit.storage_participant[fei]
    end
    
    if @email.accept_forms
      workitem.fields['forms_not_ok'] = false
      RuoteKit.storage_participant.reply(workitem)
    end
    
    respond_to do |format|
      format.html { redirect_to @email }
    end
  end
  
  def reject_forms
    @email = Email.find(params[:id])
    if ( fei = Ruote::FlowExpressionId.from_id(params[:email][:fei_id]) )
      workitem = RuoteKit.storage_participant[fei]
    end

    workitem.fields['forms_not_ok'] = true
    
    RuoteKit.storage_participant.reply(workitem)
    
    respond_to do |format|
      format.html { redirect_to @email }
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.xml
  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html { redirect_to(emails_url) }
      format.xml  { head :ok }
    end
  end
end
