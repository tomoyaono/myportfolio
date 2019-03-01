class SubimageUploader < CarrierWave::Uploader::Base
 # Include RMagick or MiniMagick support:
   if Rails.env.production?
     include Cloudinary::CarrierWave
     
     process :convert => 'png' # 画像の保存形式
     process :tags => ['image'] # 保存時に添付されるタグ（管理しやすいように適宜変更しましょう）

     process :resize_to_limit => [1000, 1000] # 任意でリサイズの制限

     # 保存する画像の種類をサイズ別に設定
     version :standard do
     process :resize_to_fill => [100, 150, :north]
     end

     version :thumb do
       process :resize_to_fit => [50, 50]
     end
  
   else
     include CarrierWave::RMagick
     
     storage :file

  #storage :file
  # storage :fog

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

end
