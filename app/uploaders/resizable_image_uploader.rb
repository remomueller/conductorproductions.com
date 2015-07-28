# encoding: utf-8

class ResizableImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    project_param = (Rails.env.test? ? model.project.slug.to_s : model.project.id.to_s)
    # location_param = (Rails.env.test? ? model.location.slug.to_s : model.location.id.to_s)
    location_param = model.location.id.to_s
    model_param = model.id.to_s
    File.join("projects", project_param, "locations", location_param, "photos", model_param)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process resize_to_limit: [1024, 1024]

  # Create different versions of your uploaded files:
  version :preview do
    process resize_to_fill: [360, 360]
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "photo#{File.extname(original_filename)}" if original_filename
  end

end
