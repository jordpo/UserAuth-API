source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'rails-api', '~> 0.3.0'
gem 'pg', '~> 0.18.1'
gem 'bcrypt-ruby', '~> 3.1'
gem 'active_model_serializers', '~> 0.8.3'
gem 'puma', '~> 2.8.2'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
end

group :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'shoulda-matchers', require: false
  gem 'vcr', '~> 2.9.3'
  gem 'webmock'
  gem 'rspec-its', '~> 1.0.1'
end

group :development, :test do
  gem 'fabrication'
  gem 'faker'
  gem 'annotate'
  gem 'byebug'
end
