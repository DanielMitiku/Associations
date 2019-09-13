require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user2@example.com", password: "foobar", password_confirmation: "foobar")
  end
  test "should be valid" do
    assert @user.valid?
  end



RSpec.describe User, type: :model do
  it { should have_many(:events) }

  it "has many events" do
    expect(User).to have_many(:events)
  end
end
end

