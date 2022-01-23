class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
#↑has_many:tweets：１ユーザーで複数のツイートを所持しているため、user.rb側がhas_manyになる
  has_many :comments
  #１ユーザーで複数のコメントを投稿するためhas_many :commentsとなる
end