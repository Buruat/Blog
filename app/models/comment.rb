class Comment < ApplicationRecord
  validates :body, presence: true, length: {minimum: 1}

  belongs_to :post
  belongs_to :user
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "post_id", "updated_at", "user_id"]
  end
end
