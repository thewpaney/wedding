source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# For database interactions
gem 'mongo'
gem 'mongoid'
# The web framework!
gem 'sinatra'
# A web server for testing
gem 'thin'
# HTML as Markup Language (>erb)
gem 'haml'
# The HTTP server
gem 'unicorn'
# For flashing nice messages
gem 'sinatra-flash'

# We also use nginx as the reverse proxy
