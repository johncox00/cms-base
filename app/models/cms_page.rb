class CmsPage < ActiveRecord::Base
  has_and_belongs_to_many :content_items, through: :cms_pages_content_items

  validates :name, presence: true, uniqueness: true
  validates :path, presence: true, uniqueness: true
end
