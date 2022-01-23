class UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        # ↑このコードが入るため「@nickname = current_user.nickname」は「@nickname = user.nickname」となり
        # 「@tweets = current_user.tweets.order("cre〜」は「@tweets = user.tweets.order("cre〜」となる。
        # なぜなら、上記コードでコメント欄等で表示されたユーザー名をクリックすることで送られたidをサーバーのusersから取得し「User.find(params[:id])」
        # user に代入。
        
    
        #nicknameは現在ログイン中のユーザーのニックネームをusersサーバーから返します。
        @nickname = user.nickname
        #ツイート内容はAcctiveRecordのWhereメソッドを使い、サーバーのtweetsに格納したツイートからログイン中ユーザーのデータを取り出す。
        #@tweets = Tweet.where(user_id: current_user.id) サーバーのusersとtweetsを各モデルでアソシエーションするとこのコードは不要となる。
        @tweets = user.tweets.order("created_at DESC").page(params[:page]).per(5)
        #アソシエーション（has_many:とbelongs_to:)を確立すると上記の内容で、ツイートを取得できる。
        #「@tweets = current_user.tweets」取得するツイートは現在ログイン中のユーザーツイートとなるので、current_user.tweets となる。
        #細かいことはすでにインポートしたプログラムがやってくれるため、アソシエーションでサーバーのモデル間を連携すればOK
        #「.order.("created_at DESC")」でツイートを作成日が新しい順にできる。current_user.tweets.order.("created_at DESC")で
        #ログイン中ユーザーのツイート作成順（サーバーのtweetsのcreated_atでDESCにすると作成日が新順になる）
        # .page(params[:page]).per(5) について、Gemファイルの「kaminari」のメソッド。.page(params[:page])はページ送りを指定するメソッドで、
        # .per(5) は１ページに表示するコンテンツ数（ここではツイート数）を（）の数字で指定する。ここでは５ツイート。
        # Gem "kaminari"でページ送り（＝ページネーション）を実現するには上記の２行とともにindex.html.erbとshow.html.erbに「<%= paginate(@tweets) %>」を追加
    end
end
