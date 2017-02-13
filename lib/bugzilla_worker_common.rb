module BugzillaWorkerCommon
  BugNotFoundError = Class.new(StandardError)

  def product
    Settings.bugzilla.product
  end

  def with_bug(bug_id)
    return unless block_given?
    BugzillaService.call do
      output = ActiveBugzilla::Bug.find(:product => product, :id => bug_id)
      raise BugNotFoundError if output.empty?
      bug = output.first
      yield(bug)
    end
  end
end
