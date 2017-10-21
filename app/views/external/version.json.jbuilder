# frozen_string_literal: true

json.version do
  json.string Conductor::VERSION::STRING
  json.major Conductor::VERSION::MAJOR
  json.minor Conductor::VERSION::MINOR
  json.tiny Conductor::VERSION::TINY
  json.build Conductor::VERSION::BUILD
end
