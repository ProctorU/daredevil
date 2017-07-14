require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "daredevil"

module Dummy
  class Application < Rails::Application
    FactoryGirl.definition_file_paths << Pathname.new("../factories")
    FactoryGirl.definition_file_paths.uniq!
    FactoryGirl.find_definitions
  end
end
