class CommentsController < ApplicationController
    def create
        comment = Comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
        #user_id: current_user.id　はアソシエイトしたサーバーのusersからidを紐づけ、
        # サーバーのcommentsのuser_idへ登録している
        redirect_to "/tweets/#{comment.tweet.id}"
        #コメントと結びつくツイートの詳細画面に遷移する
        #この#{comment.tweet.id}のcommentには上記のComment.create(te~が格納されている。
        # さらにcomment_params[:tweet_id]に含まれているサーバーのtweetsのidを引き出している
        # comment_params[:tweet_id]はtweet.idをcommentで利用するためにサーバーのtweetsにあるツイートを格納したものを
        # 加工したものだからtweetsのidを引き出せる仕組み。
        # ※あくまでもtweet.rbとcomment.rbのアソシエートとルートでのネストができていことが前提
    end
    
    private
    def comment_params
        params.permit(:text, :tweet_id)
    end
    # #なぜpermit(:text, :tweet_id)となるのか？
    #前提としてtweet.rbとcomment.rbのアソシエーションが完了していることが条件である。
    # まず:textはtweets/show.html.erbにて<textarea name="text"として定義されて、投稿したコメントのことを表す。
    # 次に、:tweet_id はroutes.rbでresources :tweetsにネストしたresources :commentsが関係する
    # ネストしたことで、tweets_controllerが動くと同時にcomments_controllerも動く。その際に、詳細で取得したtweetが
    # :tweet_idへと変換され、コメント先のtweetとつながるようになる。
    # よって、permit(:text, :tweet_id)となり、コメント作成のメソッドは
    # comment.create(text: comment_params[:text], tweet_id: comment_params[:tweet_id]　となる
end
