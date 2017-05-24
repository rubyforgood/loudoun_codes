class SubmissionRunnerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../submission_runner/templates", __FILE__)

  class_option :ext, type: :string, required: true, desc: 'required'

  def copy_submission_runner_template
    runner_file = "lib/submission_runners/#{file_name}.rb"

    copy_file "submission_runner.rb", runner_file

    gsub_file runner_file, 'placeholder.class_name', class_name
    gsub_file runner_file, 'placeholder.language_name', file_name
  end

  def copy_submission_runner_spec
    spec_file = "spec/lib/submission_runners/#{file_name}_spec.rb"

    copy_file "submission_runner_spec.rb", spec_file

    gsub_file spec_file, 'placeholder.class_name', class_name
    gsub_file spec_file, 'placeholder.language_name', file_name
    gsub_file spec_file, 'placeholder.file_extension', options['ext']
  end
end
