class Problem < ApplicationRecord
  has_many :attachments, as: :attachable
  has_many :submissions
  belongs_to :contest

  # FIXME: probably need a validator for ensuring unique names inside a contest
  # validates :name, presence: true

  WHITESPACE_RULES = ["plain diff", "ignore all whitespace", "ignore leading whitespace", "ignore trailing whitespace"]

  def uploaded_files_dir
    self.class.files_base.join("problems/#{id}")
  end

  def input_file
    # FIXME? does the `first` invocation here need to be fixed?
    attachments.where(attachment_type: "sample_in").first.path
  end

  def self.create_from_files!(name:, contest:, output_file:, input_file: nil, **options)
    input_file  = Pathname.new(input_file)
    output_file = Pathname.new(output_file)

    # FIXME: actually handle the handout_file parameter

    Problem.transaction do
      problem = Problem.create!(
        contest:   contest,
        name:      name,
        has_input: input_file.present?,
      )

      input_attachment = Attachment.create!(
        original_filename: input_file.basename,
        attachment_type:   'sample_in',
        attachable:        problem,
      )

      input_attachment.with_file('wb') do |attach_file|
        attach_file.write(input_file.read)
      end

      output_attachment = Attachment.create!(
        original_filename: output_file.basename,
        attachment_type:   'sample_out',
        attachable:        problem,
      )

      output_attachment.with_file('wb') do |attach_file|
        attach_file.write(output_file.read)
      end

      problem.save!

      problem
    end
  end
end

# == Schema Information
#
# Table name: problems
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  contest_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  timeout         :integer
#  has_input       :boolean
#  auto_judge      :boolean
#  ignore_case     :boolean
#  whitespace_rule :string           default("plain diff")
#
