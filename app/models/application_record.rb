class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def downcase_email
    self.email = email.downcase
  end
end
