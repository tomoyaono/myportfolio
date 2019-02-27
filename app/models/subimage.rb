class Subimage < ApplicationRecord
  belongs_to :product, optional: true, inverse_of: :subimages
  
  mount_uploader :sub_image, SubimageUploader
end
