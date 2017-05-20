class ProblemPresenter < SimpleDelegator
  attr_reader :problem

  def initialize(problem)
    super
    @problem = problem
  end

  def auto_judge
    problem.auto_judge ? 'Yes' : 'No'
  end

  def has_input
    problem.has_input ? 'Yes' : 'No'
  end

  def ignore_case
    problem.ignore_case ? 'Yes' : 'No'
  end

  def timeout
    if problem.timeout
      "#{(problem.timeout / 60)}m"
    else
      'N/A'
    end
  end

  def whitespace_rule
    problem.whitespace_rule
  end
end
