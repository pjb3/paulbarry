require 'mysql2'
require 'active_record'

ActiveRecord::Base.establish_connection 'mysql2://localhost/paulbarry'

class Article < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :comments
end

class Category < ActiveRecord::Base
end

class Categorization < ActiveRecord::Base
  belongs_to :article
  belongs_to :category
end

class Comment < ActiveRecord::Base
  belongs_to :article
end

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :articles, :through => :taggings
end

class Tagging < ActiveRecord::Base
  belongs_to :article
  belongs_to :tag
end

class User < ActiveRecord::Base
end

[Article, Category, Categorization, Comment, Tag, Tagging, User].each do |model|
  model.all.each do |record|
    file = "db/data/#{model.table_name}/#{record.id}.yml"
    puts "Saving #{file}..."
    open(file, "w") do |f|
      f << record.attributes.to_yaml
    end
  end

end


