class Category < ApplicationRecord
  has_many :articles

  def self.find_by_id_or_name(id_or_name)
    id_or_name.match(/^\d+$/) ? find_by_id(id_or_name) : find_by_name(id_or_name)
  end
end
