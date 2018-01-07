require 'rubygems'
require 'sequel'

class MutationPoint < Sequel::Model(:mutation_point)
  one_to_many :mutation_results,
    class: :MutationResult,
    key: :mutation_point_id,
    primary_key: :unique_id,
    eager: [:result]
end

