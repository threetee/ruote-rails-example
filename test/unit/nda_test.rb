require 'test_helper'

class NdaTest < ActiveSupport::TestCase
  should "be valid" do
    assert Nda.new.valid?
  end
end
