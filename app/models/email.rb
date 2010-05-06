class Email < ActiveRecord::Base
  PDEF_CREATE_EMAIL = Ruote.process_definition :name => 'create_email' do
    cursor do 
      requestor
      reviewer
      rewind :if => '${review_not_ok}'
      # approver
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
  
  def self.ruote_create_email(email)
    logger.debug("pdef = #{PDEF_CREATE_EMAIL}")
    RuoteKit.engine.launch(PDEF_CREATE_EMAIL, :email => email)
  end
end
