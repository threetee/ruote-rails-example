class WorkitemsController < ApplicationController
  def index
    @workitems = RuoteKit.storage_participant.all
  end

  def show
    if ( fei = Ruote::FlowExpressionId.from_id(params[:id]) )
      @workitem = RuoteKit.storage_participant[fei]
    end
  end

  def edit
    if ( fei = Ruote::FlowExpressionId.from_id(params[:id]) )
      @workitem = RuoteKit.storage_participant[fei]
    end
  end
end
