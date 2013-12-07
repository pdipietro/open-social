require 'spec_helper'

describe Credential do

  before do
    @email = Credential.new(email: "pippo@pluto.com", password: "test_pwd", password_confirmation: "test_pwd")
  end

  subject { @email }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}

  #it { should be_valid }

  describe "when email address is already taken" do
    before do
      same_email = @email.dup
      same_email.email = @email.email.upcase
      same_email.save
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @email = Credential.new(email: "user2@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

=begin
  describe "when password doesn't match confirmation" do
    before { @email.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @email.password = @email.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @email.save }
    let(:found_user) { email.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
=end

end
