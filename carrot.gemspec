# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "carrot"
  s.version = "1.3.0"
  s.date = "2020-03-24"
  s.authors = ["Amos Elliston","Scott Steadman"]
  s.email = "scott.steadman@geni.com"
  s.homepage = "http://github.com/geni/carrot"
  s.description = "A synchronous version of the ruby amqp client"
  s.summary = "A synchronous version of the ruby amqp client"
  s.license = 'MIT'

  s.files = Dir['lib/**/*.rb']
  s.require_paths = ["lib"]
end
