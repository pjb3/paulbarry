class FixSequences < ActiveRecord::Migration[6.0]
  def change
    %w[
      articles
      categories
      comments
      taggings
      tags
      users
    ].each do |table|
      max_id = select_value %{select max(id) + 1 from #{table}}
      execute %{alter sequence #{table}_id_seq restart with #{max_id}}
    end
  end
end
