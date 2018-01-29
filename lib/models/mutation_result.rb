require 'rubygems'
require 'sequel'

class MutationResult < Sequel::Model(:mutation_result)
  one_to_one :result,
    class: :ExecutionResult,
    key: [:test_id, :mutation_point_id],
    primary_key: [:test_id, :mutation_point_id]

  def killed?
    result.status.equal? 1
  end

  def survived?
    result.status.equal? 2
  end

  def timed_out?
    result.status.equal? 3
  end

  def crashed?
    result.status.equal? 4
  end

  def abnormal_exit?
    result.status.equal? 5
  end

  def dryRun?
    result.status.equal? 6
  end

  def status
    case result.status
    when 1
      "Killed"
    when 2
      "Survived"
    when 3
      "Timed Out"
    when 4
      "Crashed"
    when 5
      "Abnormal Exit"
    when 6
      "Dry Run"
    else
      "unknown"
    end
  end

  def duration
    humanize_duration result.duration
  end

  def source
    begin
    code = SourceManager.instance.source_for_file_at_line filename, line
    caret = " " * (column - 1)
    caret[column - 1] = "^"
    "#{code}#{caret}"
    rescue
      return "not_found"
    end
  end

  def stderr
    result.stderr
  end

  def stdout
    result.stdout
  end

end

