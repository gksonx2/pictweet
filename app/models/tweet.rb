class Tweet < ApplicationRecord
    belongs_to :user
    #サーバーのusersの各ユーザーに複数のツイートが所属する.belong_to :userとなる。
    #（userが単数になるのも１ユーザー複数ツイート所持の考えから）
    has_many :comments
    #コメントが複数１つのtweetにつくためhas_many :commentsとなる
end
#上記の「ApplicationRecord」のclass内容をTweetへ引き継いでいる。「ApplicationRecord」に
