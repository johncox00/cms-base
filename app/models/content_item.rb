class ContentItem < ActiveRecord::Base
  belongs_to :container, class_name: 'ContentItem', foreign_key: 'container_id'
  has_many :content_item_revisions

  def contained
    ContentItem.where(container_id: self.id).to_a
  end

  def recursive_contained
    cont = contained
    ret = [cont]
    cont.each do |c|
      ret << c.recursive_contained
    end
    return ret
  end

  def current_content
    content_item_revisions.where(change_set_id: ChangeSet.current.map(&:id)).last
  end

  def content_for_change_set(change_set)
    content_item_revisions.where(change_set_id: change_set.id).last
  end
end
