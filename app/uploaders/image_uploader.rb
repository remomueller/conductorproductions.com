# frozen_string_literal: true

# Allows files to be attached to photos.
class ImageUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    project_param = (Rails.env.test? ? model.slug.to_s : model.id.to_s)
    File.join("#{model.class.to_s.underscore.pluralize}", project_param, mounted_as.to_s)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # TODO: Remove this function with carrierwave 1.0.0
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # TODO: This will replace the above function in carrierwave 1.0.0
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end
