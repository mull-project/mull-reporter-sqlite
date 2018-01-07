require './lib/services/mutant_sorter'
require './lib/presenters/mutation_operator_presenter'

class ReportPresenter
  def initialize(mutants)
    sorter = MutantSorter.new
    @mutants = sorter.sort(mutants)

    @killed_mutants_count = @mutants.count { |m| m.killed? }
    @survived_mutants_count = @mutants.count { |m| m.survived? }
    @weakly_killed_mutants_count = @mutants.count { |m| m.weakly_killed? }
    @strongly_killed_mutants_count = @mutants.count { |m| m.strongly_killed? }
  end

  def mutants
    @mutants
  end

  def killed_mutants_count
    @killed_mutants_count
  end

  def survived_mutants_count
    @survived_mutants_count
  end

  def strongly_killed_mutants_count
    @strongly_killed_mutants_count
  end

  def weakly_killed_mutants_count
    @weakly_killed_mutants_count
  end

  def operators
    @operators
  end

  def mutation_score
    if @mutants.count == 0
      return "100%"
    end

    score = (@killed_mutants_count * 100.0 ) / @mutants.count
    "#{score.ceil}%"
  end

end

