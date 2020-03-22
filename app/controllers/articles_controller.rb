class ArticlesController < ApplicationController
  def index
    scope = if params[:category].present?
              @category = Category.find_by_id_or_name(params[:category])
              @page_title = "PaulBarry.com - #{@category.name}"
              @category.articles
            elsif params[:tag].present?
              @tag = Tag.find_by_id_or_name(params[:tag])
              @page_title = "PaulBarry.com - #{@tag.name}"
              @tag.articles
            else
              @page_title = "PaulBarry.com"
              Article
            end

    scope = scope.includes(:category)

    if params[:format].blank? || params[:format] == "html"
      @articles = scope.published.
        order("published_at desc").
        page(params[:page]).
        per(5)
      @robots_should_index = false
    else
      @articles = scope.published.order("published_at desc").limit(10)
      render layout: false
    end
  end

  def show
    @article = Article.find_by_params(params)
    @category = @article.category
    @robots_should_index = true
    @page_title = "PaulBarry.com - #{@article.title}"
  end
end
