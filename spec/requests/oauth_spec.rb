require 'spec_helper'

describe 'OauthController' do
  let!(:wrong_user) { Fabricate(:user) }
  let!(:user) { Fabricate(:user) }

  describe 'No token protected path' do
    before { get current_user_path(1), {} }
    specify { response.status.should == 401 }
  end

  describe 'No token unprotected path' do
    before { get '/status' }
    specify { response.status.should == 200 }
  end

  describe 'retrieving token with valid credentials' do
    let(:auth_params) { {
      'grant_type' => 'password',
      'username' => user.email,
      'password' => user.password
    } }
    before { post create_token_path, auth_params }
    specify { response.status.should == 200 }
    specify { response.json['access_token'].should == OauthToken.last.access_token }
  end

  describe 'retrieving token with invalid credentials' do
    let(:auth_params) { {
      'grant_type' => 'password',
      'username' => user.email,
      'password' => 'lolwat'
    } }
    before { post create_token_path, auth_params }
    specify { response.status.should == 401 }
  end

  describe 'accessing content with valid token' do
    let(:token) { OauthToken.create(user: user) }
    let(:auth_headers) { {
      'Authorization' => "Bearer #{token.access_token}"
    } }
    before { get current_user_path(1), {}, auth_headers }
    specify { response.status.should == 200 }
  end

  describe 'accessing content with an expired token' do
    let(:token) { OauthToken.create(user: user, created_at: 2.hours.ago) }
    let(:auth_headers) { {
      'Authorization' => "Bearer #{token.access_token}"
    } }
    before { get current_user_path(1), {}, auth_headers }
    specify { response.status.should == 401 }
  end

  describe 'requesting new access token with refresh token' do
    let(:token) { OauthToken.create(user: user, created_at: 45.minutes.ago) }
    let(:auth_params) { {
      'grant_type' => 'refresh_token',
      'refresh_token' => token.refresh_token
    } }
    before { post refresh_token_path, auth_params }
    specify { response.status.should == 200 }
    specify { response.json['access_token'].should == OauthToken.last.access_token }
  end

  describe 'requesting new access token with expired refresh token' do
    let(:token) { OauthToken.create(user: user, created_at: 31.days.ago) }
    let(:auth_params) { {
      'grant_type' => 'refresh_token',
      'refresh_token' => token.refresh_token
    } }
    before { post refresh_token_path, auth_params }
    specify { response.status.should == 401 }
  end
end
