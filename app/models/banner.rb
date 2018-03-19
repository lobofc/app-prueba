# Banner Model
class Banner < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :banner, AttachmentUploader

  validates_presence_of :banner

  # Fields for the search form in the navbar
  def self.search_field
    :banner_cont
  end
end
