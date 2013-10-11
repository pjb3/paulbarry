class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :articles, :through => :taggings

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.find_by_id_or_name(id_or_name)
    id_or_name.match(/^\d+$/) ? find_by_id(id_or_name) : find_by_name(id_or_name)
  end

  def self.counts(options={})
    category_ids = Array(options[:categories]).map{|c| c.id }

    limit = options[:limit].blank? ? 25 : options[:limit].to_i

    sql = %{select t.name, count(*) as count
    from tags t
    join taggings tg on t.id = tg.tag_id
    join articles a on tg.article_id = a.id
    }

    if !category_ids.blank?
      query_name = "Tag counts for Category #{category_ids.join(', ')}"
      sql << %{join categorizations cg on a.id = cg.article_id
        and cg.category_id in (#{category_ids.join(', ')})
      }
    else
      query_name = "Tag counts"
    end

    sql << %{group by t.name order by count(*) desc limit #{limit}}

    connection.select_all sql, query_name
  end


  def self.cloud(options={})
    min_font_size = 75
    max_font_size = 200
    tags = counts(options)
    max_count = tags.first["count"].to_i
    min_count = tags.last["count"].to_i

    tags.map do |tag|
      weight = (Math.log(tag["count"].to_i)-Math.log(min_count))/(Math.log(max_count)-Math.log(min_count))
      font_size = min_font_size + ((max_font_size-min_font_size)*weight).round
      OpenStruct.new(tag.merge(:font_size => font_size))
    end
  end
end
