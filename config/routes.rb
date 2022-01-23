Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #下記のtweetsは「tweets_controler.rbのことを指す
    root 'tweets#index'
    #resources　は指定しなければ、ルーティングの７つのコントローラーアクションを全部利用できる
    resources :tweets do#tweets_controllerに対して、下記の'tweets'や'tweets/new'などの箇所をresourcesはまとめてルート設定できる。
      resources :comments, only: [:create]#コメントを投稿するのみのためonly: [:create]となっている
    end
      #上記のようにtabでスペースをあけて記述しているのは、tweetsに対してコメントを行うため、
      #コメントがtweetの子になり、tweetがコメントの親になる関係性から、resources :comment〜として、
      #resources :tweetsの下部に従属させる必要があるからである。resources :tweetsが動いたらcommentも動かすため,
      #resources :tweets do ~ endの記述となっている
      
    resources :users, only: [:show]#users_controllerでshow（コントローラーアクション）のみ利用となっているため。限定している
    
    # get 'tweets' => 'tweets#index'#ツイート一覧画面。url「/tweets」でtweets_controllerのindexメソッドを呼び出す
    # get 'tweets/new' => 'tweets#new'#ツイート投稿画面。同上
    # post 'tweets' => 'tweets#create'#ツイート投稿機能。同上＆get 'tweets/new'で投稿した内容をコントローラー→モデル→sqlサーバーへ送る。 
    # get 'users/:id' => 'users#show'#Mypageへのルーティング。users_controllerで作成したshowメソッドでMypageを表示します。
    # delete 'tweets/:id' => 'tweets#destroy'# ツイートを削除するサーバーtweetsのidがツイートを司るキーです。よってtweets/:idとなります。
    # get 'tweets/:id/edit' => 'tweets#edit'#編集画面へのルーティング（誘導）
    # patch 'tweets/:id' => 'tweets#update'#編集画面で編集した投稿をサーバーに反映し、ビューにも反映するルートを作る
    # get 'tweets/:id' => 'tweets#show'#ツイート（投稿）詳細画面への道筋を作る
end
