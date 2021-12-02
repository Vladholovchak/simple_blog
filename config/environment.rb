require 'bundler/setup'
require 'hanami/setup'
require 'active_record'
db_config = YAML::load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]
require_relative '../lib/entities/application_record'
ApplicationRecord.establish_connection(db_config)
require_relative '../apps/api/application'
require "hanami/middleware/body_parser"


Hanami.configure do
  middleware.use Hanami::Middleware::BodyParser, :json
  mount Api::Application, at: '/api'

  environment :development do
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []
  end
end
