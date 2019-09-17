require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:raj)
   
    @event = @user.events.build(description: "Lorem ipsum", event_date: Date.new(2020, 12, 8)	 )
  end
  test "should be valid" do
    assert @event.valid?
  end
  
end
