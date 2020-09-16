class Comic < ApplicationRecord

	belongs_to :user
	has_many :reviews
	has_many :tag_maps, dependent: :destroy
	has_many :tags, through: :tag_maps

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

	def save_tag(sent_tags)
		current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
		old_tags = current_tags - sent_tags
		new_tags = sent_tags - current_tags

		old_tags.each do |old|
		  self.comic_tags.delete ComicTag.find_by(comic_tag_name: old)
		end

		new_tags.each do |new|
		  new_comic_tag = ComicTag.find_or_create_by(comic_tag_name: new)
		  self.comic_tags << new_comic_tag
		end
	end
end
