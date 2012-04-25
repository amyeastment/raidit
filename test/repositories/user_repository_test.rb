require 'test_helper'
require 'repositories/user_repository'

describe UserRepository do
  it "exists" do
    UserRepository.new.wont_be_nil
  end

  describe ".all" do
    it "returns the full list of users" do
      UserRepository.all.must_equal []
    end
  end
end