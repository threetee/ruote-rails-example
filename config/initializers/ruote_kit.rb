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
    participant :requestor, Ruote::StorageParticipant do |workitem|
      logger.debug "workitem before form submission = #{workitem.inspect}"
      # Submit account application form
      workitem.fields['account_application'] = "This is the account app form"    # Can this be an AR object?
      # Submit NDA form
      workitem.fields['nda'] = "This is the NDA"
      logger.debug "workitem after form submission = #{workitem.inspect}"
    end
    
    # Reviewer must make sure account app and NDA forms are completely filled out
    participant :reviewer, Ruote::StorageParticipant do |workitem|
      logger.debug "reviewing forms"
      logger.debug "workitem = #{workitem.inspect}"
      if (workitem.fields['account_application'] && workitem.fields['nda'])
        unless ( (workitem.fields['account_application'] == "This is the account app form" &&
              workitem.fields['nda'] == "This is the NDA") )
          workitem.fields['review_not_ok'] = true
        end
      end
    end

    # register the catchall storage participant named '.+'
    catchall
  end
end