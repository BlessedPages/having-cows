require 'rails_helper'

describe Product do
  
  context "when the product has comments" do
    before do
      product.comments.create!(rating: 1, user: user, body: "horrible hoodie")
      product.comments.create!(rating: 3, user: user, body: "stylish but cold")
      product.comments.create!(rating: 5, user: user, body: "my favourite hoodie")
      let(:product) { Product.create!(name: "Hoodie") }
      let(:user) { User.create!(email: "testuser@rspec.com", password: "R$p3c!") }
    end

    it "returns the average rating of all comments" do
      expect(product.average_rating).to eq(3)
    end
  end

  context "has no name assigned to product" do
    before do
      Product.new(description: "A very nice cow hat")
    end

    it "is not a valid product" do
      expect(Product.new(description: "A very nice cow hat")).not_to be_valid
    end
  end
end