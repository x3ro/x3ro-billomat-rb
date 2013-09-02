source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "shoulda", ">= 0"
  gem "bundler"
  gem "jeweler"
  gem "yard"
  gem "redcarpet" # For YARD
  gem "turn"
  gem "simplecov"
end

# Since ActiveSupport (and hence ActiveResource) has trouble
# deserializing an XML "correctly" (I'm aware that the definition
# of correct might vary), we have to additionally parse the XML
# using nokogiri.
gem "nokogiri"

gem "activeresource", "~> 3.2.8"
