class OauthTokenSerializer < ApplicationSerializer
  self.root = false # per Oauth2 spec

  attributes :access_token, :refresh_token, :expires_in, :token_type, :user_id
end
