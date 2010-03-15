class User < ActiveRecord::Base
  THUMB_W = 80
  THUMB_H = 60
  CROP_W = 400
  
  image_accessor         :avatar
  validates_presence_of  :avatar
  validates_mime_type_of :avatar, :in => %w(image/jpeg image/png image/gif)
  
end
