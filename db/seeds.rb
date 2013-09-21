# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[Article, Category, Categorization, Comment, Tag, Tagging, User].each do |model|
  Dir["db/data/#{model.table_name}/*.yml"].each do |f|
    record = model.new
    YAML.load_file(f).each do |attr, value|
      record.send("#{attr}=", value)
    end
    record.save!
    puts "Saved #{record.class}##{record.id}"
  end
end#
