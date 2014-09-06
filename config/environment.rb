# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

PagSeguro.environment = "sandbox" # production ou sandbox
PagSeguro.encoding = "UTF-8" # UTF-8 ou ISO-8859-1