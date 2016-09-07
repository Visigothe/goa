HighVoltage.configure do |config|
  # Specify root path
  config.home_page = 'home'
  # Top-level routes
  config.route_drawer = HighVoltage::RouteDrawers::Root
  # Disable routes
  # config.routes = false
  # Specify engine for routes
  # config.parent_engine = MyEngine
  # Content
  # config.content_path = 'my/file/path/'
end
