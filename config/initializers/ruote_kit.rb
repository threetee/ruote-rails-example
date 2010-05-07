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

    # Requestor must submit account app and NDA forms
    participant :requestor, Ruote::StorageParticipant
    
    # Reviewer must make sure account app and NDA forms are completely filled out
    participant :reviewer, Ruote::StorageParticipant

    # Approver has final say over whether or not account is created
    participant :approver, Ruote::StorageParticipant
    
    amqp = RuoteAMQP::Participant.new(:default_queue => 'work1')
    
    # Ingress mail servers are named ashley and kitty
    amqp.map_participant('ashley', 'ingress_work1')
    amqp.map_participant('kitty', 'ingress_work1')
    
    # Mailbox server is copper
    amqp.map_participant('copper', 'mailbox_work1')

    participant :ashley, amqp
    participant :kitty, amqp

    participant :copper, amqp
    
    # register the catchall storage participant named '.+'
    catchall
  end
end