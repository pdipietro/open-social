require 'spec_helper'

describe User do
#  let(:user) { FactoryGirl.create(:user) }

  before { @user = FactoryGirl.create(:user)}

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:nick_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

end
