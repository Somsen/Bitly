class Url < ActiveRecord::Base
  require 'uri'

  validates :full_url, presence: true
  validates :full_url, uniqueness: true

  validate :url_format

  after_validation :calculate_short

  def self.full_url_already_shortened?(full_url)
    self.exists?(full_url: full_url)
  end

  private
    def calculate_short
      self.short_url = Digest::SHA1.hexdigest(self.full_url)[0..12]
    end

    def url_format
      uri = URI.parse(self.full_url)
      unless uri.kind_of?(URI::HTTP)
        errors.add(:full_url, 'is an invalid URL')
      end
    end
end
