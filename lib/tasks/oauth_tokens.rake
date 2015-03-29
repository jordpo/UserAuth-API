namespace :oauth_tokens do
  desc "delete expired and used tokens from db"
  task delete_expired: :environment do
    OauthToken.expired_refresh_token.destroy_all
    OauthToken.where(refreshed: true).destroy_all
  end
end
