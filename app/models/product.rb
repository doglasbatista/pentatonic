class Product < ActiveRecord::Base
  belongs_to :style
  belongs_to :category
  belongs_to :user
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  usar_como_dinheiro :price
  validates :price, :numericality => {:greater_than_or_equal_to => 0.00}
  has_attached_file :cover, :styles => {:small => "100*100"}
  #validates_attachment_presence :cover
  validates_attachment_content_type :cover, :content_type => [ 'image/png','image/jpeg','image/jpeg']

  has_attached_file :file
  # validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [ 'application/zip', 'application/rar', 
                                    'application/x-rar']  
  
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false      
    end    
  end

  def self.search(query)
    if query.present?
      joins(:style).joins(:category).joins(:user).where("products.title LIKE :query OR
        categories.name LIKE :query OR
        styles.name LIKE :query OR
        users.name LIKE :query OR
        products.price LIKE :query OR
        products.description LIKE :query", query: "%#{query}%")
    else
      all
      #scoped
    end
  end
end
