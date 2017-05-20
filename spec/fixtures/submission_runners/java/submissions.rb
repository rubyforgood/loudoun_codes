(DoesntCompile = Object.new).instance_exec do
  def uploaded_files_dir
    Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java")
  end

  def source_file
    uploaded_files_dir.join("DoesntCompile.java")
  end

  def problem_name
    source_file.basename.to_s.split('.').first
  end

  def problem_input_file
    uploaded_files_dir.join("Input")
  end
end

(CompilesDoesntRun = Object.new).instance_exec do
  def uploaded_files_dir
    Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java")
  end

  def source_file
    uploaded_files_dir.join("CompilesDoesntRun.java")
  end

  def problem_name
    source_file.basename.to_s.split('.').first
  end

  def problem_input_file
    uploaded_files_dir.join("Input")
  end
end

(CompilesAndRuns = Object.new).instance_exec do
  def uploaded_files_dir
    Pathname.new(Rails.root).join("spec/fixtures/submission_runners/java")
  end

  def source_file
    uploaded_files_dir.join("CompilesAndRuns.java")
  end

  def problem_name
    source_file.basename.to_s.split('.').first
  end

  def problem_input_file
    uploaded_files_dir.join("Input")
  end
end
