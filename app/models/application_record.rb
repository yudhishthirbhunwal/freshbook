class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
