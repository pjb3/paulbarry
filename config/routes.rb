Paulbarry::Application.routes.draw do
  get 'articles/category/:category' => 'articles#index'
  get 'articles/category/:category/pages/:page' => 'articles#index', constraints: { page: /\d+/ }

  get 'articles/tag/:tag/pages/:page' => 'articles#index', constraints: { page: /\d+/ }

  get 'articles/:year/:month/:day/:slug/comments' => 'comments#index', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/
  }, as: 'article_comments'

  post 'articles/:year/:month/:day/:slug/comments' => 'comments#create', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/
  }

  get 'articles/:year/:month/:day/:slug' => 'articles#show', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/,
  }, as: 'article'

  get '/articles' => 'articles#index', as: 'articles'
  get 'articles/pages/:page' => 'articles#index', constraints: { page: /\d+/ }

  get '/xml/:format.xml' => 'articles#index'
  get '/xml/rss20/feed.xml' => 'articles#index', defaults: { format: 'rss' }

  get '/categories/:category/articles' => 'articles#index', as: 'category_articles'

  get '/categories/:category/articles/pages/:page' => 'articles#index', constraints: { page: /\d+/ }

  get '/tags/:tag/articles' => 'articles#index', as: 'tag_articles'

  get '/tags/:tag/articles/pages/:page' => 'articles#index', constraints: { page: /\d+/ }

  root :to => 'articles#index'

  namespace :admin do
    resources :articles, member: {publish: :post}
    resources :comments
    delete 'comments' => 'comments#batch_delete'
    root :to => 'articles#index'
  end
end
