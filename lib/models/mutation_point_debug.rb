require 'rubygems'
require 'sequel'

class MutationPointDebug < Sequel::Model(:mutation_point_debug)

  def source
    begin
    code = SourceManager.instance.source_for_file_at_line filename, line_number
    caret = " " * (column_number - 1)
    caret[column_number - 1] = "^"
    "#{code}#{caret}"
    rescue
      return "not_found"
    end
  end

end

