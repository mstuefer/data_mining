Gem::Specification.new do |s|
  s.name        = 'data_mining'
  s.version     = '0.0.2'
  s.date        = '2015-06-23'
  s.summary     = "Data-Mining-Algorithms"
  s.description = "A collection of data mining algorithms"
  s.authors     = ["Manuel Stuefer"]
  s.email       = 'mstuefer@gmail.com'
  s.files       = [ "lib/data_mining.rb",
                    "lib/data_mining/dbscan.rb",
                    "lib/data_mining/point.rb" ]
  s.homepage    = 'https://github.com/mstuefer/data_mining'
  s.license     = 'MIT'

  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-reporters"
end
