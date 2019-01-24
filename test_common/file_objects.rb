require_relative 'file_objects/base'
Dir.glob(File.absolute_path('../file_objects/**/*.rb', __FILE__)).each { |f| require f }
