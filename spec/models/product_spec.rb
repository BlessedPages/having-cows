require 'rails_helper'

describe Product, type: :model do
  
  context "when the product has comments" do
    before do
      @product = FactoryGirl.create(:product)
      @user = FactoryGirl.create(:user)
      @product.comments.create!(rating: 1, user: @user, body: "horrible hoodie")
      @product.comments.create!(rating: 3, user: @user, body: "stylish but cold")
      @product.comments.create!(rating: 5, user: @user, body: "my favourite hoodie")
    end
    it "returns the average rating of all comments" do
      expect(@product.average_rating).to eq(3)
    end
  end

  context "when product has no name" do
    before do
      @product = Product.create(description: "A very nice cow hat")
    end
    it "is not a valid product" do
      expect(@product).not_to be_valid
    end
  end

  context "when product has no price" do
    before do
      @product = Product.create(name: "something")
    end
    it "is not a valid product" do
      expect(@product).not_to be_valid
    end
  end
end