class Comic < ApplicationRecord

	belongs_to :user
	has_many :reviews

	validates :title, presence: true, uniqueness: true
	validates :title_kana, presence: true, uniqueness: true, format: { with: /\A[ァ-ヶー－]+\z/}
	validates :author, presence: true
	validates :publisher, presence: true
	validates :story, presence: true
	validates :back_number, presence: true

	def self.search(search)
		if search
			Comic.where(['title LIKE ? OR title_kana LIKE ? OR author LIKE ? OR publisher LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
		else
			Comic.all
		end
	end
end
