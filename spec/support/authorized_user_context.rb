shared_context 'authorized user' do
  let(:user) { Fabricate(:user) }
  let(:token) { OauthToken.create(user: user) }
  let(:auth_headers) { {"Authorization" => "Bearer #{token.access_token}"} }
end
