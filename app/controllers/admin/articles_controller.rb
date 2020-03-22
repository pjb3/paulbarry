class Admin::ArticlesController < Admin::BaseController
  before_action :load_article, only: %i[show edit update publish destroy]

  def index
    @articles = Article.page(params[:page]).per(25).order("created_at desc")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to [:admin, @article], notice: "Article was created"
    else
      @error = @article.errors.full_messages.join(", ")
      render "new"
    end
  end

  def publish
    if @article.publish
      redirect_to [:admin, @article], notice: "Article was published"
    else
      redirect_to [:admin, @article], alert: "Could not publish article: #{@article.errors.full_messages.join(", ")}"
    end
  end

  def update
    if @article.update(article_params)
      redirect_to [:admin, @article], notice: "Article was updated"
    else
      @error = @article.errors.full_messages.join(", ")
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path, notice: %{Article "#{@article.title}" was deleted}
  end

  private

  def load_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(*%i[
      title
      body
      category_id
      tag_list
    ])
  end

  helper_method def categories
    @categories ||= Category.order("name").to_a
  end
end
