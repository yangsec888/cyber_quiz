class Trainer < ActiveRecord::Base
  mount_uploader :logo, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h 
end
