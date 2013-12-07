require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "User first name", last_name: "User last name", nick_name: "User nick name") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:nick_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}

end
