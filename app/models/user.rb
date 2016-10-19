class User < ActiveRecord::Base

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :create_role_methods
  acts_as_taggable_on :roles

  def self.available_roles
    ['content_creator', 'content_approver', 'offer_creator', 'offer_approver', 'promotion_creator', 'promotion_approver', 'admin']
  end

  def set_default_role
    self.role_list ||= User.available_roles.first
  end

  def create_role_methods
    User.available_roles.each do |role|
      role_method = "#{role}?".to_sym
      define_singleton_method(role_method) do
        role_list.include? role
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
