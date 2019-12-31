class Comment < ApplicationRecord
  belongs_to :article, counter_cache: true
  validates_presence_of :article_id, :author, :body, :guid

  before_validation :set_guid, :set_author

  def self.filtered_by(filters)
    where(filters)
  end

  def set_guid
    self.guid = UUID.random_create.to_s if guid.blank?
  end

  def set_author
    self.author = ip if author.blank?
  end
end
