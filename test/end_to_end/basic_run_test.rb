# frozen_string_literal: true

require_relative "../test_helper"
require "gnome_app_driver"

# Test driver for the Wait Up application.
class WaitUpDriver < GnomeAppDriver
  def initialize
    super("wait_up")
  end
end

describe "The Wait Up application" do
  before do
    @driver = WaitUpDriver.new
    @driver.boot
  end

  it "starts and can be quit with Ctrl-q" do
    @driver.press_ctrl_q

    status = @driver.cleanup

    _(status.exitstatus).must_equal 0
  end

  after do
    @driver.cleanup
  end
end
