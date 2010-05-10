# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruote-amqp}
  s.version = "2.1.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kenneth.kalmer@gmail.com"]
  s.date = %q{2010-05-05}
  s.email = %q{kenneth.kalmer@gmail.com}
  s.extra_rdoc_files = [
    "History.txt",
     "Manifest.txt",
     "PostInstall.txt",
     "README.rdoc",
     "TODO.txt"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "Manifest.txt",
     "PostInstall.txt",
     "README.rdoc",
     "Rakefile",
     "TODO.txt",
     "lib/ruote-amqp.rb",
     "lib/ruote-amqp/launchitem_listener.rb",
     "lib/ruote-amqp/participant.rb",
     "lib/ruote-amqp/workitem_listener.rb",
     "lib/spec/ruote.rb",
     "lib/spec/ruote_example_group.rb",
     "lib/spec/ruote_helpers.rb",
     "lib/spec/ruote_matchers.rb",
     "ruote-amqp.gemspec",
     "script/console",
     "script/destroy",
     "script/generate",
     "spec/launchitem_listener_spec.rb",
     "spec/participant_spec.rb",
     "spec/ruote_amqp_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/workitem_listener_spec.rb"
  ]
  s.homepage = %q{http://github.com/kennethkalmer/ruote-amqp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{AMQP participant/listener pair for ruote 2.1}
  s.test_files = [
    "spec/launchitem_listener_spec.rb",
     "spec/participant_spec.rb",
     "spec/ruote_amqp_spec.rb",
     "spec/spec_helper.rb",
     "spec/workitem_listener_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<amqp>, [">= 0.6.7"])
      s.add_runtime_dependency(%q<ruote>, [">= 2.1.10"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<amqp>, [">= 0.6.7"])
      s.add_dependency(%q<ruote>, [">= 2.1.10"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<amqp>, [">= 0.6.7"])
    s.add_dependency(%q<ruote>, [">= 2.1.10"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
