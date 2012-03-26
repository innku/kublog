require 'spec_helper'

describe "InvitedAuthor" do
  describe "#validate" do
    subject { Factory.build(:invited_author) }

    it 'is should be valid with the default params' do
      subject.should be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      subject.should_not be_valid
    end

    it 'is invalid without an email' do
      subject.email = nil
      subject.should_not be_valid
    end

    it 'is not valid to be anonymous with an invalid email' do
      subject.email = "invalidstuff"
      subject.should_not be_valid
    end
  end
end
