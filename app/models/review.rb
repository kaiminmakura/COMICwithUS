class Review < ApplicationRecord

  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end

  belongs_to :user
  belongs_to :comic

  validates :rank, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
    }, presence: true

end
