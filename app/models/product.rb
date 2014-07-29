class Product < ActiveRecord::Base
  belongs_to :style
  belongs_to :category
  belongs_to :user

  has_attached_file :cover, :styles => {:small => "100*100"}
  #validates_attachment_presence :cover
  validates_attachment_content_type :cover, :content_type => [ 'image/png','image/jpeg','image/jpeg']

  has_attached_file :file
  # validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [ 'application/zip', 'application/rar']  
  
end
