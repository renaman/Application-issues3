class Book < ApplicationRecord
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	def Book.search(content, model, how)
  		if how == 'match'
  			Book.where(title: content, body: content)
  		elsif how  == 'foward'
  			Book.where("title LIKE?", "#{content}%")
  		elsif how == 'backward'
  			Book.where("title LIKE?", "%#{content}")
  		elsif how == 'partical'
  			Book.where("title LIKE?", "%#{content}%")
  		else
  			Book.all
  		end
  end
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
