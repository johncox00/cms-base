class ChangeSet < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User', :foreign_key => 'created_by', :validate => true
  has_many :content_item_revisions
  has_many :content_items, through: :content_item_revisions

  validate :date_diff

  scope :current, ->{where('active_at < ?', DateTime.now).where('inactive_at > ?', DateTime.now)}
  scope :future, ->{where('active_at > ?', DateTime.now)}
  scope :past, ->{where('inactive_at < ?', DateTime.now)}
  scope :accepted, ->{where(workflow_state: 'accepted')}
  scope :rejected, ->{where(workflow_state: 'rejected')}
  scope :unaccepted, ->{where("workflow_state != '?'", 'accepted')}

  include Workflow
  workflow do
    state :new do
      event :submit, :transitions_to => :awaiting_review
    end
    state :awaiting_review do
      event :review, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :accepted do
      event :reject, :transitions_to => :rejected
      event :accept, :transitions_to => :accepted
    end
    state :rejected do
      event :reject, :transitions_to => :rejected
      event :accept, :transitions_to => :accepted
    end
  end

  def date_diff
    if active_at > inactive_at
      errors.add(:active_at, "can't be later than inactive_at")
    end
  end
end
