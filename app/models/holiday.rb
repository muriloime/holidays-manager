class Holiday < ActiveRecord::Base
  validates :description, length: { maximum: 300 }
  belongs_to :usergit
end
