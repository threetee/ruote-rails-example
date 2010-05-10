require 'ruote/part/smtp_participant'

RuoteKit.configure do |config|
  # make changes if needed
  #
  # config.work_directory = 'my_special_work_dir' # defaults to File.join( Dir.pwd, "work_#{RuoteKit.env}" )
  # config.workers = 2                            # defaults to 1
  # config.run_worker = true                      # defaults to false
  # config.mode = :transient                      # defaults to :file_system

  config.register do
    # register your own participants using the participant method
    #
    # Example:
    # participant 'alice', Ruote::StorageParticipant

    participant :requestor_notification, Ruote::SmtpParticipant,
                :server => 'localhost',
                :port => 25,
                :to => 'edennis@r2d2',
                :from => 'noreply@wb.com',
                :notification => true,
                :template => "Subject: ${f:email_subject}\n\ntest email"
                
    # Requestor must submit account app and NDA forms
    participant :requestor, Ruote::StorageParticipant
    
    # Reviewer must make sure account app and NDA forms are completely filled out
    participant :reviewer, Ruote::StorageParticipant

    # Approver has final say over whether or not account is created
    participant :approver, Ruote::StorageParticipant

    # Let's try the stateless, or 'by-class' way
    participant :ashley, RuoteAMQP::Participant
    participant :kitty, RuoteAMQP::Participant
    participant :copper, RuoteAMQP::Participant
    
    RuoteAMQP::WorkitemListener.new( RuoteKit.engine )
    
    ##
    # This is the stateful, or 'by-instance' way, which doesn't work with
    # the current version of ruote-amqp and ruote 2.1:
    # amqp = RuoteAMQP::Participant.new(:default_queue => 'work1')
    # 
    # # Ingress mail servers are named ashley and kitty
    # amqp.map_participant('ashley', 'ingress_work1')
    # amqp.map_participant('kitty', 'ingress_work1')
    # 
    # # Mailbox server is copper
    # amqp.map_participant('copper', 'mailbox_work1')
    # 
    # participant :ashley, amqp
    # participant :kitty, amqp
    # 
    # participant :copper, amqp
    
    # register the catchall storage participant named '.+'
    catchall
  end
end