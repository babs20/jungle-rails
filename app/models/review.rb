class Review < ActiveRecord::Base
  validates :user, :product, :description, :rating presence: true

  belongs_to :user
  belongs_to :product
end
