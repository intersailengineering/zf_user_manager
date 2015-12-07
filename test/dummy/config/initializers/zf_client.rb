# This is needed to update the initializer automatically
# without restarting the server under development
Rails.application.config.to_prepare do
  Intersail::ZfClient.configure do |config|
    # Debug
    config.debug = true
    # Base url
    base_url = "http://wrkdev-jacopo/RestService/"
    # base_url = "http://srvdelivery.staging.vpn/RestService"
    # Process instance
    config.process_uri = "/processes"
    # config.process_base_uri = "http://wrkdev-boncri:8000"
    config.process_base_uri = base_url
    # Process def
    config.process_def_uri = "/process_defs"
    # config.process_def_base_uri = "http://wrkdev-boncri:8000"
    config.process_def_base_uri = base_url
    # Activity def
    config.activity_def_uri = "/activity_defs"
    # config.activity_def_base_uri = "http://wrkdev-boncri:8000"
    config.activity_def_base_uri = base_url
    # User
    config.user_uri = "/users"
    config.user_base_uri = base_url
    # Resource
    config.resource_uri = "/resources"
    # config.resource_base_uri = "http://wrkdev-boncri:8000"
    config.resource_base_uri = base_url
    # Unit
    config.unit_uri = "/units"
    # config.unit_base_uri = "http://wrkdev-boncri:8000"
    config.unit_base_uri = base_url
    # Role
    config.role_uri = "/roles"
    # config.role_base_uri = "http://wrkdev-boncri:8000"
    config.role_base_uri = base_url
    # Urr
    config.urr_uri = "/urrs"
    # config.urr_base_uri = "http://wrkdev-boncri:8000"
    config.urr_base_uri = base_url
    # Acl
    config.acl_uri = "/acls"
    # config.acl_base_uri = "http://wrkdev-boncri:8000"
    config.acl_base_uri = base_url
  end
end
