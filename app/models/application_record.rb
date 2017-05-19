class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.files_base
    Rails.application.files_base
  end
end
