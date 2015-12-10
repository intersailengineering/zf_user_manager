# This is needed to update the initializer automatically
# without restarting the server under development
Rails.application.config.to_prepare do
  Intersail::ZfClient.configure do |config|
    # Debug
    config.debug = true
    # Base url
    config.base_uri = "http://wrkdev-jacopo/RestService/"
  end
end
