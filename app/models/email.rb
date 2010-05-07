class Email < ActiveRecord::Base
  attr_accessible :address, :wfid, :nda
  attr_accessible :account_application_form, :account_application_form_attributes
  attr_accessible :nda, :nda_attributes
  
  # belongs_to :nda
  # belongs_to :account_application_form
  has_one :nda
  has_one :account_application_form
  
  accepts_nested_attributes_for :account_application_form, :nda
  
  validates_uniqueness_of :address
  
  PDEF_CREATE_EMAIL = Ruote.process_definition :name => 'create_email' do
    cursor do
      concurrence do
        requestor :task => 'upload_account_application_form'
        requestor :task => 'upload_nda'
      end
      reviewer :task => 'review_forms'
      rewind :if => '${forms_not_ok}'
      approver :task => 'approve_email_account'
      cancel_process :if => '${account_denied}'
      concurrence do
        kitty :command => '/sample/quote'
        ashley :command => '/sample/quote'
      end
      copper :command => '/sample/quote'
    end
  end
  
  state_machine :initial => :pending do
    event :deactivate do
      transition :active => :inactive
    end
    
    event :activate do
      transition any => :active
    end
    
    event :accept_forms do
      transition :pending => :forms_accepted
    end
    
    event :approve do
      transition :forms_accepted => :approved
    end
    
    event :reject do
      transition :forms_accepted => :rejected
    end
    
    state :pending do
    end
    
    state :forms_accepted do
    end
    
    state :approved do
    end
    
    state :rejected do
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
