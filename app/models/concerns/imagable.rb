module Imagable
  extend ActiveSupport::Concern

  included do
    has_one :image, :as => :reference
  end
end
