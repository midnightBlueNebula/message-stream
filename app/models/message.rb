class Message < ApplicationRecord
  
  belongs_to :user
  has_many   :likes,    dependent: :destroy
  has_many   :dislikes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true

end
