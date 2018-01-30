class TimelineCoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process resize_to_limit: [1030, 360]

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.image_path("fallback/timeline_fallback.jpg")
  end
  
  
  version :timeline_cover do
    process :resize_to_limit => [1030, 360]
  end
  
  version :newsfeed_cart do
    process :resize_to_limit => [1030, 430]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
