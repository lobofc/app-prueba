# Indicator Model
class Indicator < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord

  validates :name, :value, presence: {message: "No puede estar vacío el campo"}

  # Fields for the search form in the navbar
  def self.search_field
    :name_or_value_cont
  end
end
