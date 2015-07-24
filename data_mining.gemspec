Gem::Specification.new do |s|
  s.name        = 'data_mining'
  s.version     = '0.0.6'
  s.date        = '2015-07-24'
  s.summary     = "Data-Mining-Algorithms"
  s.description = "A collection of data mining algorithms"
  s.authors     = ["Manuel Stuefer"]
  s.email       = 'mstuefer@gmail.com'
  s.files       = [ "lib/data_mining.rb",
                    "lib/data_mining/dbscan.rb",
                    "lib/data_mining/point.rb",
                    "lib/data_mining/apriori.rb",
                    "lib/data_mining/page_rank.rb",
                    "lib/data_mining/euclidean_distance.rb",
                    "lib/data_mining/knn.rb" ]
  s.homepage    = 'https://github.com/mstuefer/data_mining'
  s.license     = 'MIT'

  s.add_development_dependency "minitest", "~> 5.7"
  s.add_development_dependency "minitest-reporters", "~> 1.0"
  s.add_development_dependency "simplecov", "~> 0.10"
end
