require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('sortable_has_many', '0.1.0') do |p|
  p.description    = "Adds behavior for sorting has_many relationships in various flavors."
  p.url            = "http://github.com/ProfKheel/sortable_has_many"
  p.author         = "Ilya Scharrenbroich"
  p.email          = "ilya@viewthespace.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
