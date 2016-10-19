class CmsPagesContentItem < ActiveRecord::Base
  belongs_to :cms_page
  belongs_to :content_item
end
