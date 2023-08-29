require 'rails_helper'
require 'spec_helper'

RSpec.describe Comment, type: :model do
  let(:user){create(:user)}
  let(:post){create(:post, user_id: user.id)}
  let(:comment){create(:comment, user_id: user.id, post_id: post.id)}
  context "validation tests" do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(1) }
  end
  context "association tests" do
    it {should belong_to(:post)}
    it {should belong_to(:user)}
  end
  describe "ransackable_attributes" do
    it "returns the expected attributes" do
      expect(Comment.ransackable_attributes).to eq(["body", "created_at", "id", "post_id", "updated_at", "user_id"])
    end
  end
end

