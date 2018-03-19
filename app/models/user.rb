# User Model
class User < ActiveRecord::Base
  include ActivityHistory

  before_save :create_permalink, if: :new_record?
  rolify
  validates_presence_of :name, :role_ids, :email

  # has_many :posts, dependent: :destroy relation posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def destroy
    super if should_destroy?
  end

  def update
    super if should_update?
  end

  def rol
    roles.first.name
  end

  # Get the page number that the object belongs to
  def page(order = :id)
    ((self.class.order(order => :desc)
      .pluck(order).index(send(order)) + 1)
        .to_f / self.class.default_per_page).ceil
  end

  def self.search_field
    :name_or_username_or_email_cont
  end

  private
  def should_destroy?
    id != 1
  end

  def should_update?
    id != 1
  end

  def create_permalink
    self.permalink = name.downcase.parameterize + '-' + SecureRandom.hex(4)
  end
end
