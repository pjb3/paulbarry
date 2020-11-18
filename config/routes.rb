Rails.application.routes.draw do
  get "articles/category/:category" => "articles#index"
  get "articles/category/:category/pages/:page" => "articles#index", constraints: { page: /\d+/ }

  get "articles/tag/:tag/pages/:page" => "articles#index", constraints: { page: /\d+/ }

  get "articles/:year/:month/:day/:slug/comments" => "comments#index", constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/,
  }, as: "article_comments"

  post "articles/:year/:month/:day/:slug/comments" => "comments#create", constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/,
  }

  get "articles/:year/:month/:day/:slug" => "articles#show", constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/,
  }, as: "article"

  get "/articles" => "articles#index", as: "articles"
  get "articles/pages/:page" => "articles#index", constraints: { page: /\d+/ }

  get "/xml/:format.xml" => "articles#index"
  get "/xml/rss20/feed.xml" => "articles#index", defaults: { format: "rss" }

  get "/categories/:category/articles" => "articles#index", as: "category_articles"

  get "/categories/:category/articles/pages/:page" => "articles#index", constraints: { page: /\d+/ }

  get "/topics/:tag/articles" => "articles#index", as: "topic_articles"

  get "/topics/:tag/articles/pages/:page" => "articles#index", constraints: { page: /\d+/ }

  get "/tags/:tag/articles" => redirect("/topics/%{tag}/articles")
  get "/tags/:tag/articles/pages/:page" => redirect("/topics/%{tag}/articles/pages/%{page}")

  root :to => "home#show"

  namespace :admin do
    get "/log_in" => "log_ins#new", as: "log_in"
    post "/log_in" => "log_ins#create"
    post "/log_out" => "log_ins#delete", as: "log_out"

    resources :articles do
      member do
        post "publish", as: "publish"
      end
    end
    resources :comments
    delete "comments" => "comments#batch_delete"
    root :to => "articles#index"
  end
end
