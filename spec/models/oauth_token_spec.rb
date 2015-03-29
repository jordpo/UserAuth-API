# == Schema Information
#
# Table name: oauth_tokens
#
#  id            :integer          not null, primary key
#  access_token  :string
#  refresh_token :string
#  user_id       :integer
#  refreshed     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

RSpec.describe OauthToken, :type => :model do
  it { should belong_to(:user) }

  context 'tokens' do
    subject { Fabricate.build(:oauth_token) }

    its(:access_token) { should eq nil }
    its(:refresh_token) { should eq nil }

    context 'on save' do
      before { subject.save }

      its(:access_token) { should_not eq nil }
      its(:refresh_token) { should_not eq nil }
    end
  end
end
