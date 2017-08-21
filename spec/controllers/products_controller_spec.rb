require 'rails_helper'

describe ProductsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @product1 = FactoryGirl.create(:product, name: "hoodie")
    @product2 = FactoryGirl.create(:product, name: "food")
  end

  describe "GET #index" do
    context "load merchandise page" do
      before do
        get :index
      end
      it "loads the products page with an HTTP 200 status code" do
        expect(response).to have_http_status(200)
      end
    end

    context "when product is searched" do
      before do
        get :index, params: { q: "ood" }
      end
      it "should return an array of products matching the search params" do
        expect(response).to have_http_status(200)
      end
      it "returns the matching products into @products" do
        expect(assigns(:products)).to match_array([@product1, @product2])
      end
    end
  end

  describe "GET #show" do

    context "a product is selected" do
      before do
        get :show, params: { id: @product1.id }
      end
      it "should render the show template" do
        expect(response).to render_template('show')
      end
    end
  end

  describe "GET #new" do
    context "a new product needs to be uploaded by an admin" do
      before do
        sign_in @admin
        get :new
      end
      it "should render the new template" do
        expect(response).to render_template(:new)
      end
    end

    context "a non admin tries to access the new template" do
      before do
        sign_in @user
        get :new
      end
      it "should redirect user to root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "a product needs to be edited by an admin" do
      before do
        sign_in @admin
        get :edit, params: {id: @product1.id }
      end
      it "should render the edit template of the product" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "POST #create" do
    context "an admin posts a new product" do
      before do
        sign_in @admin
      end
      it "should save the new product in the database" do
        expect{
          post :create, params: { product: FactoryGirl.attributes_for(:product) }
          }.to change { Product.count }.by(1)

        expect(response).to have_http_status(302)
      end
    end

    context "an non-admin attempts to posts a new product" do
      before do
        sign_in @user
      end
      it "should save the product in the database" do
        before = Product.all.length
        post :create, params: { product: FactoryGirl.attributes_for(:product) }

        after = Product.all.length
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
        expect(after).to eq(before)
      end
    end
  end

  describe "PATCH #update" do
    context "an existing product gets updated by an admin" do
      before do
        sign_in @admin
        @product3 = Product.create!(name: "DirtyShirt", price: 200)
      end
      it "should update the product in the database" do
        before = Product.all.length
        patch :update, params: { id: @product3, product: {name: "CleanShirt"}}
        @product3.reload

        after = Product.all.length
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(@product3)
        expect(after).to eq(before)
        expect(@product3.name).to eq("CleanShirt")
      end
    end

    context "an existing product gets updated by a non-admin" do
      before do
        sign_in @user
        @product3 = Product.create!(name: "DirtyShirt", price: 200)
      end
      it "should update the product in the database" do
        before = Product.all.length
        patch :update, params: { id: @product3, product: {name: "CleanShirt"}}
        @product3.reload

        after = Product.all.length
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
        expect(after).to eq(before)
        expect(@product3.name).to eq("DirtyShirt")
      end
    end
  end

  describe "DELETE #destroy" do
    context "a product gets deleted by an admin" do
      before do
        sign_in @admin
        @crap_product = Product.create!(name: "crap", price: 100)
      end
      it "should remove the product from the database" do
        before = Product.all.length
        delete :destroy, params: {id: @crap_product}

        after = Product.all.length
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_url)
        expect(after).to eq (before - 1)
      end
    end
  end
end
