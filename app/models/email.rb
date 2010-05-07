class Email < ActiveRecord::Base
  attr_accessible :address, :wfid
  
  belongs_to :nda
  belongs_to :account_application_form
  
  PDEF_CREATE_EMAIL = Ruote.process_definition :name => 'create_email' do
    cursor do
      concurrence do
        requestor :task => 'upload_application_form'
        requestor :task => 'upload_nda'
      end
      reviewer :task => 'review_forms'
      rewind :if => '${forms_not_ok}'
      approver
      rewind :if => '${not_approved}'
      # concurrence do
      #   kitty :command => '/sample/quote'
      #   ashley :command => '/sample/quote'
      # end
      # copper :command => '/sample/quote'
    end
  end
  
  state_machine :initial => :pending do
    event :deactivate do
      transition :active => :inactive
    end
    
    event :activate do
      transition any => :active
    end
    
    state :pending do
    end
    
    state :active do
    end

    state :inactive do
    end
  end
  
  def ruote_create_email
    logger.debug("pdef = #{PDEF_CREATE_EMAIL}")
    self.wfid = RuoteKit.engine.launch(PDEF_CREATE_EMAIL, :address => address, :object_type => :email, :object_id => id)
    self.save
  end
  
  def name
    address
  end
end
