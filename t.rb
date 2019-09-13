require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:books) }

  it "has many books" do
    expect(User).to have_many(:books)
  end
end
