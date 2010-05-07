require 'test_helper'

class AccountApplicationFormTest < ActiveSupport::TestCase
  should "be valid" do
    assert AccountApplicationForm.new.valid?
  end
end
