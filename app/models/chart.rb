# Chart Model
class Chart < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :file, AttachmentUploader

  validates_presence_of :file, :name, :value_one

  # Fields for the search form in the navbar
  def self.search_field
    :name_or_file_cont
  end
end
