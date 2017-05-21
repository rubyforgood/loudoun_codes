require 'stringio'

class Submission < ApplicationRecord
  has_one :attachment, as: :attachable, validate: true
  has_many :submission_results
  belongs_to :team
  belongs_to :problem

  validate do
    if attachment && attachment.attachment_type != 'solution'
      errors.add :attachment, 'Must be a solution'
    end
  end

  def uploaded_files_dir
    self.class.files_base.join("submissions/#{id}")
  end

  def source_file
    Pathname.new(attachment.path)
  end

  def problem_name
    problem.name
  end

  def problem_timeout
    problem.timeout || 30.seconds
  end

  def problem_input_buffer
    if problem.has_input?
      Pathname.new(problem.input_file)
    else
      StringIO.new
    end
  end

  # Requires problem, team, and filename
  # Can optionally take a file to be read from
  #
  # Returns the submission, saved if it was valid
  def self.create_from_file(**options)
    submission = Submission.new(
      problem: options[:problem],
      team:    options[:team],
    )

    path = options[:filename]
    return submission unless path
    path = Pathname.new path

    file = options[:file] || path.open('rb')

    attachment = Attachment.new(
      original_filename: path.basename,
      attachment_type:   'solution'
    )
    submission.attachment = attachment
    attachment.attachable = submission

    submission.transaction do
      return false unless submission.save
      attachment.with_file('wb') do |attach_file|
        attach_file.write file.read
        file.close
      end
    end

    submission
  end
end

# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  passed     :boolean
#  team_id    :integer
#  problem_id :integer
#  runtime    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
