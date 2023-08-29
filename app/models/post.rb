class Post < ApplicationRecord
  validates :body, presence: true
  validates :description, presence: true, length: {maximum: 100}
  validates :title, presence: true, length: {maximum: 30}

  has_many :comments, dependent: :destroy
  has_one_attached :image
  def self.ransackable_attributes(auth_object = nil)
    ["author", "body", "created_at", "description", "id", "title", "updated_at", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["comments", "image_attachment", "image_blob"]
  end
end
