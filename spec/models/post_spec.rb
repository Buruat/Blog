require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, type: :model do
  let(:user){create(:user)}
  let(:post){create(:post, user_id: user.id)}
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(100) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(30) }
  end

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one_attached(:image) }
  end

  describe 'ransackable attributes' do
    it 'includes the expected attributes' do
      expect(Post.ransackable_attributes).to eq(["author", "body", "created_at", "description", "id", "title", "updated_at", "user_id"])
    end
  end

  describe 'ransackable associations' do
    it 'includes the expected associations' do
      expect(Post.ransackable_associations).to eq(["comments", "image_attachment", "image_blob"])
    end
  end
end

