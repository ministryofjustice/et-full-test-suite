require 'site_prism'
require_relative 'capybara_selectors'
require_relative 'sections'
require_relative 'page_objects/base_page'
require_relative 'page_objects/admin/base_page'
Dir.glob(File.absolute_path('../page_objects/**/*.rb', __FILE__)).each { |f| require f }
