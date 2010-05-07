Ruote on Rails
==============

A simple example Rails app which implements a workflow for a sample
[activity diagram](http://github.com/threetee/ruote-rails-example/raw/master/email_activity_diagram.png),
using [Ruote](http://ruote.rubyforge.org) in [Rails](http://rubyonrails.org)
via [RuoteKit](http://github.com/kennethkalmer/ruote-kit). This app
is based on tosch's excellent
[ruote-on-rails](http://github.com/tosch/ruote-on-rails.git) 
sample app.


Installation
------------

*   clone (or do whatever you like to get the code) this repo:
        $ git clone git://github.com/threetee/ruote-rails-example.git  
        $ cd ruote-rails-example
*   install gem dependencies if you like (gems are vendored, so you don't
    have to)
        $ rake gems:install


Configuration
-------------

config/initializers/ruote_kit.rb has already been tweaked with participants
for the sample workflow, but you can of course change it to meet your needs.


Run
---

In one terminal, start the Rails server itself:
    $ script/server
In another terminal, start the RuoteKit worker process:
    $ rake ruote_kit:run_worker

Browse to http://localhost:3000/_ruote and you'll see there are no running
processes. You could change that using the "Launch process" link ;-)


Using Ruote from within Rails
-----------------------------

You can access Ruote's engine anywhere in your Rails code by calling
    RuoteKit.engine
So launching a workflow process is as easy as
    RuoteKit.engine.launch your_process_definition
The storage participant (used by the catchall participant) is available at
    RuoteKit.storage_participant


Usage
--------

To kick off a sample Ruote workflow, do the following:

1. Create a new email at http://localhost:3000/emails/new. Note the 'pending' state for the newly-created email account.
2. Check http://localhost:3000/workitems. You should see two new workitems (one for account app form submission and one for NDA submission).
3. Click the edit link for each of the above workitems and upload a sample image. This will complete the workitems required of the 'requestor' participant (see the requestor swimlane in the sample activity diagram). Hit http://localhost:3000/emails to see the state change for the email record.
4. Check http://localhost:3000/workitems again. You should now see one workitem, this one for the 'reviewer' participant. Click the edit link for this workitem to approve or reject the submitted forms.
5. Hit http://localhost:3000/workitems once more. If you rejected the submitted forms, the workflow will have been rewound to the requestor participant's tasks, so you will see the two workitems that were presented back in step 2. If you accepted the submitted forms, you will see the workitem for the 'approver' participant. http://localhost:3000/emails should also reflect another state change.
6. Edit the 'approver' participant's workitem. The 'approver' participant has final say over whether or not the email address should be created. If you (as the approver) deny this workitem, the workflow will terminate and the email's state will be set accordingly. If you approve the workitem, workflow will complete at the moment, but eventually will call AMQP remote participants to provision the email account on various servers.

TODO
----

* Implement AMQP
* Implement email notifications to participants