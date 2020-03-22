class AddCategoryIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :category, null: true, foreign_key: true

    update %{
      with article_categories as (
        select article_id, min(category_id) as category_id
        from categorizations
        group by article_id
      )

      update articles
      set category_id = ac.category_id
      from article_categories ac
      where articles.id = ac.article_id
    }

    change_column_null :articles, :category_id, false

    drop_table :categorizations
  end
end
