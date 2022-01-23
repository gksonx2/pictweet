class TweetsController < ApplicationController
    
    before_action :move_to_index, except: :index#privateに記載したメソッドmove_to_indexはユーザーがログインしていない場合動く。before_actionではログインしていない場合。メソッドindexを除いて下記メソッドを実行しないことをここに記載している。
    def index
        #サーバーではtweetsだが、Tweet.allを@tweets格納でツイートの全てを一覧表示できる
        @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
        # .includes(:user)について１ユーザーに対し複数ツイートがある。tweet.rbとuser.rb アソシエート後、この文章で複数のtweetとそれに紐づくユーザーをサーバーから適切に表示できる。
        # ↑これはサーバーの負荷を軽減するコードでもある。
        #ツイートを作成順に表示する（orderメソッド＋（サーバーのtweetsのcreated_atでDESCにすると作成日が新順になる））
        # .page(params[:page]).per(5) について、Gemファイルの「kaminari」のメソッド。.page(params[:page])はページ送りを指定するメソッドで、
        # .per(5) は１ページに表示するコンテンツ数（ここではツイート数）を（）の数字で指定する。ここでは５ツイート。
        # Gem "kaminari"でページ送り（＝ページネーション）を実現するには上記の２行とともにindex.html.erbとshow.html.erbに「<%= paginate(@tweets) %>」を追加

    end
    
    def new
    end
    
    def create #保存のメソッド
        #保存したいデータを格納する引数としてさらにサーバーのtweetsの各項目＋メソッド[メソッドで許した項目]を（）内に入れる。
        #user_id: :current_user.id の「user_id」はサーバーのtweetsの項目。そしてcurrent_「user.id」の「」部分はサーバーusersのidをさす。
        #これらの内容を新規で登録する。※モデル間（サーバーの項目間）の連携でこれが実現するため、モデルの更新が必要となる。
        # 「name: tweet_params[:name],」はuser.rbとtweet.rbアソシエート後は不要となるので、削除
        # サーバーのtweetsからnameを削除する「rails g migration RemoveNameFromTweets name:string」を行い、削除用のマイグレファイルを作成し、マイグレする
        Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    end
    
    def destroy
        #下記にてサーバーtweetsから削除予定のツイートidを取得。tweetsの構造の内容（＝配列）の中のidを取得するためparams[:id]となっている
       tweet =  Tweet.find(params[:id])
       #下記にてサーバーのtweetのuser_idとusersのidが同じであれば、上記で呼び出したツイートを削除するようコードを記述
       #短く書くとこうなる
       tweet.destroy if tweet.user_id == current_user.id
    # #   長いのはこれ
    # #   if tweet.user_id == current_user.id
    # #       tweet.destroy
    #   end
    end
    
    def edit
        #下記コードで「編集対象のツイートを取得し、@tweetへ代入する
        @tweet = Tweet.find(params[:id])        
    end
    
    def update
        tweet = Tweet.find(params[:id])
        if tweet.user_id == current_user.id
            tweet.update(tweet_params)
            #なぜTweet.create(image: tweet_params[:image], text: tweet_params[:text])ではなく
            #tweet_params なのか？ これはedit.html.erb側でサーバーの構造名であるimageとtextを
            #@tweet.image,@tweet.textと入力し記述することで、当該ビューのpatchが動く際に連動するため tweet_paramsでまとめられるから
        end
    end
    
    def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments.includes(:user)
    end
    
    private
    def tweet_params#def createの（）引数部分に入るメソッド.フォーム内容をサーバーへ保存する.
    # user.rbとtweet.rbのアソシエートが終わったら、params.permit(:name, :image, :text)から下記へ変更する（ニックネーム入力不要のため）
        params.permit(:image, :text)
    end
    
    def move_to_index
        #下記でユーザーが未ログイン時にindexページへ戻るようにしている
        redirect_to action: :index unless user_signed_in?
    end
    
end
