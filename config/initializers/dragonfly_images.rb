require 'dragonfly/rails/images'

app = Dragonfly[:images]

app.configure do |c|
  
  c.job :custom_crop do |size|
    md = size.match('(\d+):(\d+):(\d+)x(\d+)')
    process :crop, :x => md[1], :y => md[2],  :width  => md[3], :height => md[4]
  end

end
