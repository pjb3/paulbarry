class Article < ApplicationRecord
  belongs_to :category
  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings

  validates_presence_of :title, :slug, :guid, :format

  before_validation :set_slug, :set_guid, :set_format

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end

  def formatted_body
    self.class.markdown.render(body).html_safe
  end

  def self.published
    where("published_at < ?", Time.current)
  end

  def self.published_on(date)
    where("published_at BETWEEN ? AND ?", date.beginning_of_day, date.beginning_of_day + 1.day)
  end

  def self.with_slug(slug)
    where(slug: slug)
  end

  def permalink
    if published_at
      "/articles/%04d/%02d/%02d/%s" % [published_at.year, published_at.month, published_at.day, slug]
    end
  end

  def permalink_params
    if published_at
      {
        year: ("%04d" % published_at.year),
        month: ("%02d" % published_at.month),
        day: ("%02d" % published_at.day),
        slug: slug,
      }
    else
      {}
    end
  end

  def publish
    update(published_at: Time.current)
  end

  def published?
    published_at.present?
  end

  def published_date
    published_at && published_at.strftime("%B %e, %Y")
  end

  def self.find_by_params(params)
    find_by_permalink(Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i), params[:slug])
  end

  def self.find_by_permalink(published_at, slug)
    published_on(published_at).with_slug(slug).first ||
      raise(ActiveRecord::RecordNotFound.new("Could not find article '#{slug}' published at '#{published_at}'"))
  end

  def set_slug
    self.slug ||= title.to_s.parameterize
  end

  def set_guid
    self.guid ||= UUID.new.generate
  end

  def set_format
    self.format ||= "Markdown"
  end

  def tag_list
    @tag_list ||= tags.order("name").pluck(:name).join(" ")
  end

  def tag_list=(tag_list)
    @tag_list = tag_list
    self.tag_ids = Tag.where(name: @tag_list.to_s.split(" ")).pluck(:id)
  end
end
