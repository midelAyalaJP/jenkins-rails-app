class Concept < ApplicationRecord
  belongs_to :category

  validates :spanish_description, presence:true
  validates :category_id, presence: true
end
