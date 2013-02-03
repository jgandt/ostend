SPEC_ROOT_DIR = File.dirname(__FILE__)

require 'simplecov'

SimpleCov.start

# require_relative File.expand_path(File.join(SPEC_ROOT_DIR, '../lib'))
Dir.glob( SPEC_ROOT_DIR + '../lib/**/*') do  |load_file| 
    require_relative load_file
end
require 'ostend'

