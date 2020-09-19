class TagMap < ApplicationRecord
  belongs_to :comic
  belongs_to :tag
end
