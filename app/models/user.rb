class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 自分がお気に入りしたユーザの一覧を出したい
  has_many :favorite_books, through: :favorites, source: :book


  # フォロー・フォロワー機能を作る
  has_many :relationships
  # 自分がフォローしている人たち
  has_many :followings, through: :relationships, source: :follow

  # relationshipのキーをfollow_idとしてみたときのやつ
  has_many :reverse_relationships, class_name: 'Relationship',foreign_key: 'follow_id' 
  has_many :followers, through: :reverse_relationships, source: :user

  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :introduction ,length: {maximum: 50}

  def follow(other_user)
    relationships.create(follow_id: other_user.id)
  end

  def unfollow(other_user)
    relationships.find_by(follow_id: other_user.id).destroy
  end

  def follow?(other_user)
    self.followings.include?(other_user)
  end

end
