# DataMining

DataMining is a little collection of several Data-Mining-Algorithms.
Since is written in pure ruby and does not depend on any extension,
it is platform independent.

## Alogrithms

### Already implemented
1. Density Based Clustering (DBSCAN)

### Coming soon
2. Apriori
3. k-Means
4. k-Nearest Neighbor Classifier
4. Naive Bayes

## Installation

  $ gem install data_mining

## Usage

### Density Based Clustering

```ruby
  input_data = [[:point1, 1], [:point2, 2], [:point3, 10]]
  radius = 3
  min_points = 2
  dbscan = DataMining::DBScan.cluster(input_data, radius, min_points)
  dbscan.build!

  dbscan.clusters #gives 1 cluster found containing point1 and point2

  dbscan.outliers #gives point3 as outlier
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

(The MIT License)

