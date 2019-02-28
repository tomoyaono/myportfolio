class ImageUploader < CarrierWave::Uploader::Base
 # Include RMagick or MiniMagick support:
 #include CarrierWave::RMagick
 if Rails.env.production?
   include Cloudinary::CarrierWave
  else
  include CarrierWave::RMagick
 end
  
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # 画像の上限を700pxにする
  process :resize_to_limit => [1000, 1000]

  # 保存形式をJPGにする
  process :convert => 'jpg'

  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_fill => [300, 300]
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end
  
  def public_id
    return model.id
  end

 # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
 # 正方形のサムネを作る  
  def create_square
    manipulate! do |img|
      narrow = img.columns > img.rows ? img.rows : img.columns
      img.crop(Magick::CenterGravity, narrow, narrow).resize(size, size)
    end
  end
end
