class User < ActiveRecord::Base
  THUMB_W = 80
  THUMB_H = 60
  CROP_W = 400

  validates_format_of :name, :with => /\A[a-z0-9]+\z/i

  image_accessor         :avatar
  validates_presence_of  :avatar
  validates_mime_type_of :avatar, :in => %w(image/jpeg image/png image/gif)

end
