class Product < ApplicationRecord
  belongs_to :user, inverse_of: :products
  
  has_many :subimages, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :subimages, allow_destroy: true, reject_if: :all_blank
  
  mount_uploader :image, ImageUploader
end
