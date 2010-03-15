require 'dragonfly'

module Dragonfly
  module Processing
 
    class RMagickProcessor
      
      # Processing methods
      
      def crop_and_resize(temp_object, opts={})
        crop_x  = opts[:cx].to_i
        crop_y  = opts[:cy].to_i
        crop_w  = opts[:cw].to_i
        crop_h  = opts[:ch].to_i
        final_w = opts[:fw].to_i
        final_h = opts[:fh].to_i
 
        image = rmagick_image(temp_object)
 
        # RMagick throws an error if the cropping area is bigger than the image,
        # when the gravity is something other than nw
        crop_w = image.columns - crop_x if crop_x + crop_w  > image.columns
        crop_h = image.rows    - crop_y if crop_y + crop_h > image.rows
 
        cropped_image = image.crop(crop_x, crop_y, crop_w, crop_h)
        cropped_image.resize(final_w, final_h).to_blob
      end
 
    end
 
  end
end

# Set up and configure the dragonfly app
app = Dragonfly::App[:images]
app.configure_with(Dragonfly::RMagickConfiguration)
app.configure do |c|
  c.log = Rails.logger
  c.datastore.configure do |d|
    d.root_path = "#{Rails.root}/public/system/img"
  end
  c.url_handler.configure do |u|
    u.secret = '77383bbff8b9312738fa7e502d96accec9a4d322'
    u.path_prefix = '/media'
  end
end

app.parameters.add_shortcut(/^(\d+):(\d+):(\d+)x(\d+)=>(\d+)x(\d+)$/) do |string, match_data|
  {
    :processing_method => :crop_and_resize,
    :processing_options => {
      :cx => match_data[1],
      :cy => match_data[2],
      :cw => match_data[3],
      :ch => match_data[4],
      :fw => match_data[5],
      :fh => match_data[6],
    }
  }
end

# Extend ActiveRecord
# This allows you to use e.g.
#   image_accessor :my_attribute
# in your models.
ActiveRecord::Base.extend Dragonfly::ActiveRecordExtensions
ActiveRecord::Base.register_dragonfly_app(:image, Dragonfly::App[:images])

### Insert the middleware ###
# Where the middleware is depends on the version of Rails
middleware = Rails.respond_to?(:application) ? Rails.application.middleware : ActionController::Dispatcher.middleware
middleware.insert_after Rack::Lock, Dragonfly::Middleware, :images

# UNCOMMENT THIS IF YOU WANT TO CACHE REQUESTS WITH Rack::Cache
require 'rack/cache'

middleware.insert_before Dragonfly::Middleware, Rack::Cache, {
  :verbose     => true,
  :metastore   => "file:#{Rails.root}/tmp/dragonfly/cache/meta",
  :entitystore => "file:#{Rails.root}/tmp/dragonfly/cache/body"
}


