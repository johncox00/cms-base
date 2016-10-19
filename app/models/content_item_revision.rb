class ContentItemRevision < ActiveRecord::Base
  belongs_to :parent, :class_name => 'ContentItemRevision', :foreign_key => 'content_item_revision_id', :validate => true
  belongs_to :change_set
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by', :validate => true
  belongs_to :modifier, :class_name => 'User', :foreign_key => 'last_modified_by', :validate => true
  belongs_to :content_item


  def children
    ContentItemRevision.where(content_item_revision_id: self.id)
  end
end
