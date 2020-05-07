class User < ApplicationRecord
  include JpPrefecture

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
  jp_prefecture :prefecture_code

  attachment :profile_image, destroy: false

  has_many :books,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name,presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def User.search(content, model, how)
      if how == 'match'
        User.where(name: content)
      elsif how  == 'foward'
        User.where("name LIKE?", "#{content}%")
      elsif how == 'backward'
        User.where("name LIKE?", "%#{content}")
      elsif how == 'partical'
        User.where("name LIKE?", "%#{content}%")
      else
        User.all
      end
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def follow(user_id)
  	follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
  	follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
  	following_user.include?(user)
  end

end
