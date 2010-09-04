class User < ActiveRecord::Base
  THUMB_W = 80
  THUMB_H = 60
  CROP_W = 400

  validates_format_of :name, :with => /\A[a-z0-9]+\z/i

  image_accessor        :avatar
  validates_presence_of :avatar
  validates_property    :mime_type, :of => :avatar, :in => %w(image/jpeg image/png image/gif)

  def crop_hash
    # 0:78:90x68
    self.avatar_cropping
    md = self.avatar_cropping.match('(\d+):(\d+):(\d+)x(\d+)')
    { :x => md[1], :y => md[2],  :width  => md[3], :height => md[4] }
  end
  
end
