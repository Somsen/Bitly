class Url < ActiveRecord::Base

  validates :full_url, presence: true
  
  after_validation :calculate_short

  private
    def calculate_short
      return unless self.persisted?
    end



end
