# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process resize_to_fit: [640, 640]

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "fallback/user.gif"
  end
  
  process :auto_orient    
  def auto_orient
    manipulate! do |image|
      image.auto_orient
      image
    end
  end
    
  # :user_avatar the small image we use to display for ex obline_users / comments image
  version :user_avatar do
    process :resize_to_limit => [300, 300]
  end
  
  version :square do
    process :resize_to_fill => [50, 50]
  end

  version :medium do
    process :resize_to_fill => [150, 150]
  end
    
  version :large_square do
    process :resize_to_fill => [332, 332]
  end
  
  version :large do
    process :resize_to_limit => [640, 640]
  end
  
  version :banner do
    process :resize_to_limit => [980, 450]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_limit => [200, 200]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
