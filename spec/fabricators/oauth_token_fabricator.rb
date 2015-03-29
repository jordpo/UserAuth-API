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

Fabricator(:oauth_token) do
  user
  refreshed false
end
