# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:oauth_tokens).dependent(:destroy) }
  it { should validate_presence_of(:email) }
end
