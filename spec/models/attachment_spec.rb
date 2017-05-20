require 'rails_helper'

# Stubs out something that quacks like Problem or Submission
# but uses temp files so we don't pollute the filesystem.
class TestAttachable < Problem
  def uploaded_files_dir
    Dir::Tmpname.tmpdir
  end
end

RSpec.describe Attachment, type: :model do
  it 'provides a pathname for the file location' do
    filename   = 'test123.pdf'
    attachment = described_class.new(original_filename: filename, attachable: TestAttachable.new)

    expect(attachment.path.to_s).to match(/test123\.pdf$/)
  end

  it 'provides an interface for reading and writing' do
    filename   = 'test456.txt'
    text       = "abc\n123"
    attachment = described_class.new(original_filename: filename, attachable: TestAttachable.new)
    output     = ''

    attachment.with_file('w') do |file|
      file.write(text)
    end

    attachment.with_file('r') do |file|
      file.each do |line|
        output << line
      end
    end

    expect(output).to eq(text)

    File.delete(attachment.path) # cleanup after the test
  end
end

# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  original_filename :string
#  content_type      :string
#  attachable_id     :integer
#  attachable_type   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  attachment_type   :string
#
