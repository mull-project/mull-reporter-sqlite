require 'rubygems'
require 'data_mapper'

class MullConfig
  include DataMapper::Resource
  storage_names[:default] = "config"
  property :rowid, Serial

  property :project_name, String
  property :time_start, Integer
  property :time_end, Integer
end
